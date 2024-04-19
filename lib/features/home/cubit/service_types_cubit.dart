import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comunect_v2/features/find_a_service/repositories/service_type_repo.dart';
import 'package:comunect_v2/features/find_a_service/models/service_type.dart';
import 'package:meta/meta.dart';

part 'service_types_state.dart';

class ServiceTypesCubit extends Cubit<ServiceTypesState> {
  ServiceTypesCubit() : super(ServiceTypesLoading());
  final _serviceTypeHelper = ServiceTypeRepository();

  Future<void> loadServiceTypes() async {
    List<ServiceType> types = await _serviceTypeHelper.getObjectList(
      filters: {},
      limit: 6
    );
    emit(ServiceTypesLoaded(serviceTypes: types));
  }

  void selectServiceType(int index) {
    var loadedState = state as ServiceTypesLoaded;
    emit(ServiceTypesSelected(
      serviceTypes: loadedState.serviceTypes, 
      indexOfSelectedType: index
    ));
  }

  void removeSelected() {
    var selected  = state as ServiceTypesSelected;
    emit(ServiceTypesLoaded(serviceTypes: selected.serviceTypes));
  }
}
