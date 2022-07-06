part of 'device_details_cubit.dart';

@immutable
abstract class DeviceDetailsState {}

class DeviceDetailsInitial extends DeviceDetailsState {}

class AddDeviceDetailsLoadingState extends DeviceDetailsState {}

class AddDeviceDetailsSuccessState extends DeviceDetailsState {}

class AddDeviceDetailsEmptyState extends DeviceDetailsState {}

class AddDeviceDetailsErrorState extends DeviceDetailsState {}
