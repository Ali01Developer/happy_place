import 'package:flutter/material.dart';

class AddLocationManually extends StatefulWidget {
  final Function(double aa, double aaa) valuesPasser;
  AddLocationManually({Key? key, required this.valuesPasser}) : super(key: key);

  @override
  State<AddLocationManually> createState() => _AddLocationManuallyState();
}

class _AddLocationManuallyState extends State<AddLocationManually> {
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  bool _isButtonActive = false;

  void _onTextFieldChange(String value) {
    setState(() {
      _isButtonActive =
          _latController.text.isNotEmpty && _lonController.text.isNotEmpty;
    });
  }

  void _onAddTap() {
    final double latitude = double.parse(_latController.text);
    final double longitude = double.parse(_lonController.text);
    widget.valuesPasser(latitude, longitude);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: (MediaQuery.of(context).viewInsets.bottom + 40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Location",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: _onTextFieldChange,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Latitude",
              ),
              controller: _latController,
            ),
            SizedBox(height: 15),
            TextField(
              onChanged: _onTextFieldChange,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Longitude",
              ),
              controller: _lonController,
            ),
            SizedBox(height: 15),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _isButtonActive ? _onAddTap : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Text("Add Location"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
