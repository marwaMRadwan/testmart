part of 'zones_cubit.dart';

@immutable
abstract class ZonesState {}

class ZonesInitial extends ZonesState {}

class GetZonesDataLoadingState extends ZonesState {}

class GetZonesDataSuccessState extends ZonesState {}

class GetZonesDataEmptyState extends ZonesState {}

class GetZonesDataErrorState extends ZonesState {}

class ChangeZoneState extends ZonesState {}
