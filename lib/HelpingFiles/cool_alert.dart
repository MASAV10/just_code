import 'package:flutter/material.dart';

class MyCoolAlerts {
  myError({required String contentOfAlert, required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          elevation: 8,
          actions: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 0),
                    width: double.infinity,
                    color: Colors.pink,
                    child: Text(
                      'Error \n Oopsssy',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Text(contentOfAlert, textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(elevation: 3),
                        child: Text('OK!'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
