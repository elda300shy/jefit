import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isRecording = false;
  bool isSending = false;
  int _correctExerciseCount = 0; // Counter for correct exercises

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.isNotEmpty) {
        controller = CameraController(cameras![0], ResolutionPreset.medium);
        controller!.initialize().then((_) {
          if (!mounted) return;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void startRecording() async {
    if (controller != null && controller!.value.isInitialized && !isRecording) {
      try {
        await controller!.startVideoRecording();
        setState(() {
          isRecording = true;
        });
      } catch (e) {
        print('Error starting video recording: $e');
      }
    }
  }

  void stopRecording() async {
    if (controller != null && controller!.value.isInitialized && isRecording) {
      try {
        XFile videoFile = await controller!.stopVideoRecording();
        setState(() {
          isRecording = false;
          isSending = true; // Set sending flag to true while sending the video
        });
        await sendVideo(videoFile);
        setState(() {
          isSending = false; // Reset sending flag after video is sent
        });
      } catch (e) {
        print('Error stopping video recording: $e');
        setState(() {
          isRecording = false;
          isSending = false; // Ensure sending flag is reset on error
        });
      }
    }
  }

  Future<void> sendVideo(XFile videoFile) async {
    try {
      final bytes = await videoFile.readAsBytes();
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/upload'),
        headers: {'Content-Type': 'application/octet-stream'},
        body: bytes,
      );

      if (response.statusCode == 200) {
        print('Video uploaded successfully');
        var result = response.body;
        // Assuming the server returns 'true' or 'false' for correct exercise
        if (result.toLowerCase() == 'true') {
          setState(() {
            _correctExerciseCount++;
          });
        }
      } else {
        print('Failed to upload video: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: CameraPreview(controller!),
      floatingActionButton: FloatingActionButton(
        child: Icon(isRecording ? Icons.stop : Icons.videocam),
        onPressed: isSending ? null : (isRecording ? stopRecording : startRecording),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Correct Exercises: $_correctExerciseCount',
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _correctExerciseCount = 0;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
