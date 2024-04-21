import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comunect_v2/features/find_a_service/models/job.dart';
import 'package:comunect_v2/features/find_a_service/repositories/job_repo.dart';
import 'package:meta/meta.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsLoading());

  static final jobRepository = JobRepository();

  Future<void> loadJobs(String serviceId) async {
    List<Job> jobs = await jobRepository.getObjectList(filters: {
      JobRepository.fieldServiceType: serviceId
    });

    emit(JobsLoaded(jobs: jobs));
  }

  void selectJob(int index) {
    var loadedState = state as JobsLoaded;

    emit(JobsSelected(
      jobs: loadedState.jobs, 
      indexOfSelectedJob: index
    ));
  }
}
