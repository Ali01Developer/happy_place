import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      this.location,
      required this.image});
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  String? addess;

  PlaceLocation({required this.latitude, required this.longitude, this.addess});
}
