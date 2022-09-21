import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).getAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text("No places yet"),
                ),
                builder: (context, greatPlaces, child) => greatPlaces
                        .items.isEmpty
                    ? child ?? Container()
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[index].image),
                            ),
                            title: Text(greatPlaces.items[index].title),
                            subtitle: Text(
                              greatPlaces.items[index].location?.addess ?? "",
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailsScreen.routeName,
                                arguments: greatPlaces.items[index].id,
                              );
                            },
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
