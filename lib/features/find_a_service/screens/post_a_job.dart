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
      appBar: AppBar(title: const Text('Post a job'),),
      bottomNavigationBar: bottomNavigation(context: context),
      body: body(),
    );
  }

  final _jobFormKey = GlobalKey<FormState>();

  Widget body() {
    return SingleChildScrollView(
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
    );
  }

  List<Widget> serviceType() {
    return [
      const Text('Service Type:'), 
      Row(
        children: [
          Image.network(_serviceType.selected.imageUrl as String),
          Text(_serviceType.selected.name)
        ],
      )
    ];  
  }

  final _descriptionoController = TextEditingController();

  List<Widget> jobDescription() {
    return [
      const Text('Job Description'),
      TextFormField(
        controller: _descriptionoController,
        maxLines: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please add a description';
          }
          _descriptionoController.text = value;
          return null;
        },
      )
    ];
  }

  bool _hasErrorOnPhotos = false;

  List<Widget> addPhotos() {
    return [
      const Text('Add Photos'),
      Wrap(
        direction: Axis.horizontal,
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          ...selectedPhotos(),
          addPhoto()
        ],
      ),
      if(_hasErrorOnPhotos) 
      const Text(
        'Please add atleast one photo',
        style: TextStyle(color: Colors.red),
      )
    ];
  }
  
  List<File> _photos = [];

  List<Widget> selectedPhotos() {
    return List.generate(
      _photos.length, 
      (index) {
        return Image.file(
          _photos[index],
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        );
      }
    );
  }


  ElevatedButton addPhoto() {
    return ElevatedButton(
      onPressed: () async {
        List<File>? images = await pickMultipleImages();
        if (images == null) { return; }
        setState(() => _photos = images);
      }, 
      child: const Icon(Icons.add)
    );
  }

  final _locationController = TextEditingController();

  List<Widget> location() {
    return [
      const Text('Location'),
      TextFormField(
        controller: _locationController,
        validator: (value) {
          if (value == null || value.isEmpty) { 
            return 'Please add a location';
          }
          _locationController.text = value;
          return null;
        },
      )
    ];
  }

  final jobRepository = JobRepository();

  bool _jobIsBeingPosted = false;

  Widget postBtn() {
    return Center(
      child: ElevatedButton(
        onPressed: postJob, 
        child: _jobIsBeingPosted
          ? const CircularProgressIndicator()
          : const Text('Post')
      ),
    );
  }

  void postJob() async {
    bool formsAreValid = _jobFormKey.currentState!.validate();
    bool hasAddedAPhoto = _photos.isNotEmpty;
    setState(() => _hasErrorOnPhotos = !hasAddedAPhoto);

    if (!formsAreValid || !hasAddedAPhoto) { return; }
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