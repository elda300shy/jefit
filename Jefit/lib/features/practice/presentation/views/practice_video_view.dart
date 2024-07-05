import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jefit/core/common/widget/app_text_button.dart';
import 'package:jefit/features/practice/data/lower_body_model.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:jefit/features/practice/presentation/widgets/camera_screen.dart';

class PracticeVideoView extends StatefulWidget {
  const PracticeVideoView({Key? key, required this.model}) : super(key: key);

  final LowerBodyModel model;

  @override
  State<PracticeVideoView> createState() => _PracticeVideoViewState();
}

class _PracticeVideoViewState extends State<PracticeVideoView>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _showCamera = false;

  late AnimationController _countdownController;
  late Animation<double> _countdownAnimation;

  int _correctExerciseCount = 0; // Track the count of correct exercises

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.model.videoAsset ?? "")
      ..initialize().then((_) {
        setState(() {});
      });

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _countdownAnimation =
    Tween<double>(begin: 3.0, end: 0.0).animate(_countdownController)
      ..addListener(() {
        setState(() {});
      });

    // Initialize cameras on initState
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    // Fetch available cameras
    List<CameraDescription> cameras = await availableCameras();

    // Use the first camera from the list
    final firstCamera = cameras.first;

    // Initialize CameraController
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    // Initialize camera controller and update state
    await _cameraController?.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      if (await Permission.camera.request().isGranted) {
        _initializeCameras().then((_) {
          setState(() {
            _showCamera = true;
          });
        });
      } else if (await Permission.camera.isPermanentlyDenied) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Camera Permission'),
              content:
              const Text('Please enable camera permission from settings'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    child: const Text('OK'))
              ],
            );
          },
        );
      }
    } else if (status.isGranted) {
      _initializeCameras().then((_) {
        setState(() {
          _showCamera = true;
        });
      });
    }
  }

  Future<void> _processImageWithAI(XFile imageFile) async {
    try {
      // Convert image to bytes
      List<int> imageBytes = await imageFile.readAsBytes();

      // Prepare the request
      var url = Uri.parse('http://127.0.0.1:5000/upload'); // Ensure your URL is correct
      var request = http.MultipartRequest('POST', url);
      request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: 'image.jpg'));

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var result = jsonDecode(responseBody);

        // Update the correct exercise count based on AI model result
        if (result['isCorrectExercise'] == true) {
          setState(() {
            _correctExerciseCount++;
          });
        }
      } else {
        print('Error calling AI model: ${response.statusCode}');
      }
    } catch (e) {
      print('Error processing image with AI: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cameraController?.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.model.title),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _controller.value.isInitialized
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  height: _controller.value.size.height / 2.3,
                  width: _controller.value.size.width / 2.3,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      Center(
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 50,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 10),
              _isCameraInitialized && _showCamera
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AppTextButton(
                  buttonText: "Stop Training",
                  onPressed: () {
                    _cameraController?.stopImageStream();
                    setState(() {
                      _showCamera = false;
                    });
                  },
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AppTextButton(
                  buttonText: "Start Training",
                  onPressed: () {
                    _requestCameraPermission();
                  },
                ),
              ),
              if (_showCamera && _isCameraInitialized)
                ElevatedButton(
                  onPressed: () async {
                    try {
                      XFile imageFile = await _cameraController!.takePicture();
                      _processImageWithAI(imageFile);
                    } catch (e) {
                      print('Error taking picture: $e');
                    }
                  },
                  child: Text('Process Image with AI'),
                ),
              // Display the count of correct exercises
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Correct Exercises: $_correctExerciseCount',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (_showCamera && _isCameraInitialized)
            Positioned(
              top: 180.0, // Adjust this value based on your layout
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 220,
                  left: 25,
                  right: 25,
                ),
                child: CameraPreview(
                  _cameraController!,
                ),
              ),
            ),
          // Add a button to navigate to CameraScreen
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(),
                    ),
                  );
                },
                child: Text('Open Camera Screen'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
