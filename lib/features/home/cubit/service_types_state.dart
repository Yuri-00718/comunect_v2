part of 'service_types_cubit.dart';

@immutable
sealed class ServiceTypesState {}

final class ServiceTypesLoading extends ServiceTypesState {}

final class ServiceTypesLoaded extends ServiceTypesState {
  final List<ServiceType> serviceTypes;

  ServiceTypesLoaded({required this.serviceTypes});
}

final class ServiceTypesSelected extends ServiceTypesLoaded {
  ServiceTypesSelected({
    required super.serviceTypes,
    required this.indexOfSelectedType,
  });

  final int indexOfSelectedType;

  ServiceType get selected => serviceTypes[indexOfSelectedType];
}