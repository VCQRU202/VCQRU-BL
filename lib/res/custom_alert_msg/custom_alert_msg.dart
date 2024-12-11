import 'package:flutter/material.dart';

enum AlertType {
  success,
  error,
  info,
}

class CustomAlert {
  static void showMessage(BuildContext context, String title, String message, AlertType type) {
    Color color;
    IconData icon;
    switch (type) {
      case AlertType.success:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case AlertType.error:
        color = Colors.red;
        icon = Icons.error;
        break;
      case AlertType.info:
        color = Colors.blue;
        icon = Icons.info;
        break;
      default:
        color = Colors.black;
        icon = Icons.info;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: color, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
