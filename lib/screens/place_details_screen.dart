import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static final routeName = "/product-details";

  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectPlace.location?.addess ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              MapsLauncher.launchCoordinates(selectPlace.location!.latitude,
                  selectPlace.location!.longitude);
            },
            child: Text("Open Map"),
          )
        ],
      ),
    );
  }
}
