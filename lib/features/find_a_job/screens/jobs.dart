import 'package:comunect_v2/common/widgets/bottom_navigation.dart';
import 'package:comunect_v2/features/find_a_job/cubit/jobs_cubit.dart';
import 'package:comunect_v2/features/find_a_service/models/job.dart';
import 'package:comunect_v2/features/home/cubit/service_types_cubit.dart';
import 'package:comunect_v2/routes/routes_names.dart';
import 'package:comunect_v2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late ServiceTypesCubit _serviceTypesCubit;
  late JobsCubit _jobsCubit;
  late ServiceTypesSelected _selectedServiceType;

  @override
  void initState() {
    super.initState();
    _serviceTypesCubit = context.read<ServiceTypesCubit>();
    _jobsCubit = context.read<JobsCubit>();
    _selectedServiceType = _serviceTypesCubit.state as ServiceTypesSelected;
    loadjobs();
  }

  void loadjobs() async {
    await _jobsCubit.loadJobs(_selectedServiceType.selected.id as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBE2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EBE2),
        title: const Text(
          'Available jobs',
          style: TextStyle(
            fontSize: 24, // Increase font size
          ),
        ),
      ),
      body: body(),
      bottomNavigationBar: bottomNavigation(
        context: context,
        activePage: jobsPage,
      ),
    );
  }

  Widget body() {
    return BlocBuilder<JobsCubit, JobsState>(
      builder: (context, state) {
        if (state is JobsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        state = state as JobsLoaded;
        List<Job> jobs = state.jobs;

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          padding: const EdgeInsets.all(10.0),
          children: List.generate(jobs.length, (index) {
            String description = jobs[index].description;
            String displayedDesc = description.length > 30
                ? "${description.substring(0, 30)}..."
                : description;

            return GestureDetector(
              onTap: () {
                _jobsCubit.selectJob(index);
                Navigator.pushNamed(context, jobDetails);
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF5DEBD7), // Change color here
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayedDesc,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        jobs[index].location,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    _serviceTypesCubit.removeSelected();
    super.dispose();
  }
}
