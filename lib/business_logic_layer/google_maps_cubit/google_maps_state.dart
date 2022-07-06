part of 'google_maps_cubit.dart';

@immutable
abstract class GoogleMapsState {}

class GoogleMapsInitial extends GoogleMapsState {}


class GetCurrentLocationSuccessState extends GoogleMapsState {}
class GetCurrentLocationErrorState extends GoogleMapsState {}

class GetAddressState extends GoogleMapsState {}

class CheckLocationPermissionSuccessState extends GoogleMapsState {}

class CheckLocationPermissionDeniedState extends GoogleMapsState {}


