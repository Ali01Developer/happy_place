import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  final VoidCallback onAddManuallyTap;
  final VoidCallback onCurrentLocationTap;

  final double lat;
  final double lon;

  const LocationInput({
    Key? key,
    required this.onAddManuallyTap,
    required this.onCurrentLocationTap,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _previewImageUrl == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Currently we only store current locations !!!",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text("Latitude: ${widget.lat}"),
                    SizedBox(height: 5),
                    Text("Longitude: ${widget.lon}")
                  ],
                )
              : Image.network(
                  _previewImageUrl ?? "",
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: widget.onCurrentLocationTap,
              icon: Icon(Icons.location_on),
              label: Text(
                "Current Location",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error occured !"),
                    content: Text(
                        "Sorry currently we are unable to provide this feature !!!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      )
                    ],
                  ),
                );
              },
              icon: Icon(Icons.map),
              label: Text(
                "Select on Map",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: widget.onAddManuallyTap,
          icon: Icon(Icons.location_city_outlined),
          label: Text(
            "Add Location Manuallly",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
