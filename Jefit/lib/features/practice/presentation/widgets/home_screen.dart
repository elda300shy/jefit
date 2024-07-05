import 'package:flutter/material.dart';
import 'package:jefit/features/practice/presentation/widgets/camera_screen.dart';

import 'camera_screen.dart'; // Adjust the import path

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open Camera'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraScreen()),
            );
          },
        ),
      ),
    );
  }
}
