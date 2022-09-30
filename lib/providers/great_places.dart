import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  void addPlace(
    String title,
    File image,
    double latitude,
    double longitude,
    String address,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        addess: address,
      ),
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();


  }

  Future<void> getAndSetPlaces() async {
    final placesList = await DBHelper.getData("user_places");
    _items = placesList.map((place) {
      return Place(
        id: place['id'],
        title: place['title'],
        image: File(place['image']),
        location: PlaceLocation(
          latitude: place['loc_lat'],
          longitude: place['loc_lng'],
          addess: place['address'],
        ),
      );
    }).toList();

  }

  Place findById(String id) {
    return _items.firstWhere((element) => id == element.id);
  }
}
