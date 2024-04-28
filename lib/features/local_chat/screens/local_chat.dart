import 'package:comunect_v2/common/styles/decorations.dart';
import 'package:comunect_v2/common/widgets/bottom_navigation.dart';
import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/features/authentication/repositories/user_repo.dart';
import 'package:comunect_v2/features/local_chat/cubit/chat_cubit.dart';
import 'package:comunect_v2/features/local_chat/models/message.dart';
import 'package:comunect_v2/features/local_chat/repository/chat_repo.dart';
import 'package:comunect_v2/utils/colors.dart';
import 'package:comunect_v2/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalChatScreen extends StatefulWidget {
  const LocalChatScreen({super.key});

  @override
  State<LocalChatScreen> createState() => _LocalChatScreenState();
}

class _LocalChatScreenState extends State<LocalChatScreen> {
  final _chatRepo = ChatRepository();
  final _userRepo = UserRepository();
  
  late ScrollController  _chatListController;

  late UserCubit _userCubit;
  late ChatCubit _chatCubit;
  late User _user;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _chatCubit = context.read<ChatCubit>();
    _chatListController = ScrollController();
    var authUser = _userCubit.state as AuthenticatedUser;
    _user = authUser.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Chat'),
      ),
      bottomNavigationBar:
          bottomNavigation(context: context, activePage: localChatPage),
      bottomSheet: bottomSheet(),
      body: body(),
    );
  }

  final _messageController = TextEditingController();
  final _messageFormKey = GlobalKey<FormState>();

  Widget bottomSheet() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Form(
            key: _messageFormKey,
            child: Expanded(
              child: TextFormField(
                controller: _messageController,
                onFieldSubmitted: (value) => _sendMessage(),
              ),
            ),
          ),
          GestureDetector(onTap: _sendMessage, child: const Icon(Icons.send))
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }

    await _chatRepo.sendChat(
        message: _messageController.text, sender: _user.email as String);

    _messageController.text = '';
  }

  Widget body() {
    return StreamBuilder(
      stream: _getStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Center(child: Text('No data available'));
        }

        dynamic data = snapshot.data!.snapshot.value;

        _chatCubit.loadChat(data);

        return chatMessagesList();
      },
    );
  }

  Stream<DatabaseEvent> _getStream() {
    return _chatRepo
      .chatRoomRef
      .child('naga')
      .orderByChild('timestamp')
      .limitToLast(20)
      .onValue;
  }

  BlocBuilder<ChatCubit, ChatState> chatMessagesList() {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        
        List<Message> messages = []; 

        if (state is ChatLoaded) {
          messages = state.messages;
          Future.delayed(
            Duration(milliseconds: 100),
            _goToBottom
          );
        }

        return listView(messages);
      },
    );
  }

  Widget listView(List<Message> messages) {
    return ListView.separated(
      controller: _chatListController,
      itemCount: messages.length + 1,
      separatorBuilder:(context, index) => const SizedBox(height: 10.0,), 
      itemBuilder:(context, index) {
        if (index == messages.length) {
          return const SizedBox(height: 70.0,);
        }
        var message = messages[index];
    
        if (message.sender.email == _user.email) {
          return _messageSentWidget(message);
        } 
    
        return _messageReceivedWidget(message);
      }, 
    );
  }

  void _goToBottom() {
    _chatListController.jumpTo(
      _chatListController.position.maxScrollExtent,
    );
  }

  Padding _messageSentWidget(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sentMessage(message),
          const SizedBox(width: 10.0,),
          _profilePic(message)
        ],
      ),
    );
  }

  Container _sentMessage(Message message) {
    return Container(
      color: const Color(blue1),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('You'),
          Text(message.text)
        ],
      )
    );
  }

  Padding _messageReceivedWidget(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profilePic(message),
          const SizedBox(width: 10.0,),
          receivedMessage(message),
        ],
      ),
    );
  }

  Widget receivedMessage(Message message) {
    return Container(
      color: const Color(gray1),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.sender.username),
          Text(message.text)
        ],
      )
    );
  }

  Container _profilePic(Message message) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecorations.decoration1(),
      child: message.sender.profileUrl.isNotEmpty 
        ? Image.network(message.sender.profileUrl)
        : Image.asset(
            'assets/images/profile.png',
            width: 30.0,
            height: 30.0,
          ),
    );
  }
}
