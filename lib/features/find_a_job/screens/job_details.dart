// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:comunect_v2/common/widgets/bottom_navigation.dart';
import 'package:comunect_v2/features/authentication/cubit/user_cubit.dart';
import 'package:comunect_v2/features/find_a_job/cubit/jobs_cubit.dart';
import 'package:comunect_v2/features/find_a_job/repositories/bid_repo.dart';
import 'package:comunect_v2/features/home/cubit/service_types_cubit.dart';
import 'package:comunect_v2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late ServiceTypesCubit _serviceTypesCubit;
  late UserCubit _userCubit;
  late JobsCubit _jobsCubit;
  late JobsSelected _selectedJob;
  late ServiceTypesSelected _selectedService;
  late AuthenticatedUser _authenticatedUser;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _serviceTypesCubit = context.read<ServiceTypesCubit>();
    _jobsCubit = context.read<JobsCubit>();
    _selectedJob = _jobsCubit.state as JobsSelected;
    _selectedService = _serviceTypesCubit.state as ServiceTypesSelected;
    _authenticatedUser = _userCubit.state as AuthenticatedUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBE2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EBE2),
        title: const Text(
          'Job Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: body(),
      ),
      bottomNavigationBar: bottomNavigation(
        context: context,
        activePage: jobsPage,
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          serviceType(),
          const SizedBox(
            height: 20.0,
          ),
          ...jobDescription(),
          const SizedBox(
            height: 20.0,
          ),
          ...photos(),
          const SizedBox(
            height: 20.0,
          ),
          ...location(),
          const SizedBox(
            height: 20.0,
          ),
          bidBtn(),
        ],
      ),
    );
  }

  Widget serviceType() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF5DEBD7),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adjusts width to fit content
        children: [
          Image.network(
            _selectedService.selected.imageUrl as String,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _selectedService.selected.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> jobDescription() {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          'Job Description',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          _selectedJob.selected.description,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ];
  }

  List<Widget> photos() {
    List<String> photos = _selectedJob.selected.photosUrl;

    return [
      const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          'Photos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: [
          for (int index = 0; index < photos.length; ++index)
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Image.network(
                photos[index],
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    ];
  }

  List<Widget> location() {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          'Location',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          _selectedJob.selected.location,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    ];
  }

  Widget bidBtn() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 1), // Add padding from the top
        child: ElevatedButton(
          onPressed: showBidDialog,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Add border radius
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 20, horizontal: 40), // Adjust padding
          ),
          child: const Text('Bid'),
        ),
      ),
    );
  }

  void showBidDialog() {
    var bidRepository = BidRepository();
    var bidPriceController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Make a Bid'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: bidPriceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please add a price';
                }
                return null;
              },
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  bool isValid = formKey.currentState!.validate();

                  if (!isValid) {
                    return;
                  }

                  await bidRepository.makeABid({
                    BidRepository.fieldBidPrice:
                        double.parse(bidPriceController.text),
                    BidRepository.fieldIsAccepted: false,
                    BidRepository.fieldBidder: _authenticatedUser.user.email,
                    BidRepository.fieldBiddedJob: _selectedJob.selected.id
                  });

                  Navigator.pop(dialogContext);
                  showSuccessSnackBar();
                },
                child: const Text('Bid'))
          ],
        );
      },
    );
  }

  void showSuccessSnackBar() {
    var snackBar = const SnackBar(content: Text('You have successfully bid!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
