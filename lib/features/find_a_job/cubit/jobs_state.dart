part of 'jobs_cubit.dart';

@immutable
sealed class JobsState {}

final class JobsLoading extends JobsState {}

final class JobsLoaded extends JobsState {
  final List<Job> jobs;

  JobsLoaded({required this.jobs});
}

final class JobsSelected extends JobsLoaded {
  final int indexOfSelectedJob;
  
  JobsSelected({
    required super.jobs,
    required this.indexOfSelectedJob,
  });

  Job get selected => jobs[indexOfSelectedJob];
}