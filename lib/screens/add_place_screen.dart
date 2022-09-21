import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/custom_logger.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../widgets/add_location_manually.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    final location = await Location.instance.getLocation();
    setState(() {
      latitude = location.latitude ?? 0.0;
      longitude = location.longitude ?? 0.0;
    });
  }

  void _savePlace() async {
    if (_titleController.text.trim().isEmpty || _pickedImage == null) {
      return;
    } else {
      Provider.of<GreatPlaces>(context, listen: false).addPlace(
        _titleController.text,
        _pickedImage!,
        latitude,
        longitude,
        "Address Not available",
      );
      Navigator.of(context).pop();
    }
  }

  void _getBottomSheetValues(double lat, double lon) {
    setState(() {
      latitude = lat;
      longitude = lon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(
                      lat: latitude,
                      lon: longitude,
                      onAddManuallyTap: () => _showBottomSheet(context),
                      onCurrentLocationTap: () => _init(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
            ),
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text("Add Place"),
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bCtx) {
        return AddLocationManually(
          valuesPasser: _getBottomSheetValues,
        );
      },
    ).then((value) {
      Logger.makeLog(value.toString());
    });
  }
}
