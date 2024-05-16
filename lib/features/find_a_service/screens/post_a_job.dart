// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:comunect_v2/common/widgets/bottom_navigation.dart';
import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/features/find_a_service/repositories/job_repo.dart';
import 'package:comunect_v2/features/find_a_service/utils/pick_multiple_image.dart';
import 'package:comunect_v2/features/home/cubit/service_types_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  late ServiceTypesCubit _serviceTypesCubit;
  late ServiceTypesSelected _serviceType;
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _serviceTypesCubit = context.read<ServiceTypesCubit>();
    _serviceType = _serviceTypesCubit.state as ServiceTypesSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBE2), // Set background color
      appBar: AppBar(
        title: Text(
          'Post a job',
          style: TextStyle(fontSize: 24), // Adjust title text font size
        ),
        backgroundColor:
            const Color(0xFFF5EBE2), // Set app bar background color
      ),
      bottomNavigationBar: bottomNavigation(context: context),
      body: body(),
    );
  }

  final _jobFormKey = GlobalKey<FormState>();

  Widget body() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
      child: SingleChildScrollView(
        child: Form(
          key: _jobFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...serviceType(),
              ...jobDescription(),
              ...addPhotos(),
              ...location(),
              postBtn()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> serviceType() {
    return [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0), // Adjust vertical padding
        child: Text(
          'Service Type',
          style: TextStyle(
            fontSize: 16, // Adjust font size
            fontWeight: FontWeight.bold, // Make text bold
            fontFamily: 'Poppins', // Use Poppins font
          ),
        ),
      ),
      Container(
        width: 260, // Adjust container width
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFF5DEBD7),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _serviceType.selected.imageUrl as String,
                width: 90,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _serviceType.selected.name,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    ];
  }

  final _descriptionoController = TextEditingController();

  List<Widget> jobDescription() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0), // Adjust vertical padding
        child: Text(
          'Job Description',
          style: TextStyle(
            fontSize: 16, // Adjust font size
            fontWeight: FontWeight.bold, // Make text bold
            fontFamily: 'Poppins', // Use Poppins font
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0), // Adjust padding
        decoration: BoxDecoration(
          color: Colors.grey
              .withOpacity(0.5), // Set semi-transparent container color
          borderRadius: BorderRadius.circular(8), // Set border radius
          boxShadow: [
            BoxShadow(
              color: Colors.white
                  .withOpacity(0.2), // Set semi-transparent shadow color
              spreadRadius: 5, // Set spread radius
              blurRadius: 20, // Set blur radius
              offset: const Offset(0, 2), // Set shadow offset
            ),
          ],
        ),
        child: TextFormField(
          controller: _descriptionoController,
          maxLines: null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please add a description';
            }
            _descriptionoController.text = value;
            return null;
          },
          style: TextStyle(
            fontSize: 14, // Adjust font size of text field
            fontFamily: 'Poppins', // Use Poppins font
          ),
          decoration: InputDecoration(
            border: InputBorder.none, // Remove text field border
            hintText: 'Enter job description...', // Add hint text
            hintStyle: TextStyle(
              fontSize: 14, // Adjust font size of hint text
              fontFamily: 'Poppins', // Use Poppins font
            ),
          ),
        ),
      ),
    ];
  }

  bool _hasErrorOnPhotos = false;

  List<Widget> addPhotos() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          'Add Photos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      Wrap(
        direction: Axis.horizontal,
        spacing: 8.0,
        runSpacing: 4.0,
        children: [...selectedPhotos(), addPhoto()],
      ),
      if (_hasErrorOnPhotos)
        const Text(
          'Please add at least one photo',
          style: TextStyle(color: Colors.red),
        )
    ];
  }

  List<File> _photos = [];

  List<Widget> selectedPhotos() {
    return List.generate(_photos.length, (index) {
      return Image.file(
        _photos[index],
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      );
    });
  }

  ElevatedButton addPhoto() {
    return ElevatedButton(
      onPressed: () async {
        List<File>? images = await pickMultipleImages();
        if (images == null) {
          return;
        }
        setState(() => _photos = images);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(100, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  final _locationController = TextEditingController();

  List<Widget> location() {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 16), // Add padding from the top
        child: Text(
          'Location',
          style: TextStyle(
            fontSize: 18, // Increase font size
            fontWeight: FontWeight.bold, // Make text bold
            fontFamily: 'Poppins', // Use Poppins font
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: _locationController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please add a location';
            }
            _locationController.text = value;
            return null;
          },
          style: TextStyle(
            fontSize: 16, // Adjust font size
            fontFamily: 'Poppins', // Use Poppins font
          ),
          decoration: InputDecoration(
            border: InputBorder.none, // Remove text field border
            hintText: 'Enter location...', // Add hint text
            hintStyle: TextStyle(
              fontSize: 16, // Adjust font size of hint text
              fontFamily: 'Poppins', // Use Poppins font
            ),
          ),
        ),
      ),
    ];
  }

  final jobRepository = JobRepository();

  bool _jobIsBeingPosted = false;
  Widget postBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 16), // Add padding from the top
      child: Center(
        child: ElevatedButton(
          onPressed: postJob,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Add border radius
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 20, horizontal: 40), // Adjust padding
          ),
          child: _jobIsBeingPosted
              ? const CircularProgressIndicator()
              : const Text('Post'),
        ),
      ),
    );
  }

  void postJob() async {
    bool formsAreValid = _jobFormKey.currentState!.validate();
    bool hasAddedAPhoto = _photos.isNotEmpty;
    setState(() => _hasErrorOnPhotos = !hasAddedAPhoto);

    if (!formsAreValid || !hasAddedAPhoto) {
      return;
    }
    setState(() => _jobIsBeingPosted = true);
    var state = _userCubit.state as AuthenticatedUser;

    jobRepository.addNewJob({
      JobRepository.fieldServiceType: _serviceType.selected.id,
      JobRepository.fieldDescription: _descriptionoController.text,
      JobRepository.fieldLocation: _locationController.text,
      JobRepository.fieldPhotos: _photos,
      JobRepository.fieldPostedBy: state.user.email,
    });

    jobIsPostedSnackbar();

    setState(() {
      _photos = [];
      _jobIsBeingPosted = false;
    });

    _descriptionoController.text = '';
    _locationController.text = '';
  }

  void jobIsPostedSnackbar() {
    var snackBar = const SnackBar(content: Text('Job is posted!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _serviceTypesCubit.removeSelected();
    super.dispose();
  }
}
