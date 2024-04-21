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
  State<JobsScreen> createState() =>
      _JobsScreenState();
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
      appBar: AppBar(title: const Text('Available jobs')),
      body: body(),
      bottomNavigationBar: bottomNavigation(
        context: context,
        activePage: jobsPage
      ),
    );
  }

  Widget body() {
    return BlocBuilder<JobsCubit, JobsState>(
      builder: (context, state) {
        if (state is JobsLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        state = state as JobsLoaded;
        List<Job> jobs = state.jobs;

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            String description = jobs[index].description;
            String displayedDesc = description.length > 30 
              ? "${description.substring(0, 30)}..."
              : description;
            
            return ListTile(
              onTap: () {
                _jobsCubit.selectJob(index);
                Navigator.pushNamed(context, jobDetails);
              },
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(displayedDesc),
                  Text(jobs[index].location)
                ],
              ),
            );
          },
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
