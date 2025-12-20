import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../../../../core/widgets/gradient_background.dart';

class EmotionDetectorScreen extends StatefulWidget {
  const EmotionDetectorScreen({super.key});

  @override
  State<EmotionDetectorScreen> createState() => _EmotionDetectorScreenState();
}

class _EmotionDetectorScreenState extends State<EmotionDetectorScreen> {
  final ImagePicker _picker = ImagePicker();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableTracking: true,
    ),
  );

  File? _image;
  String? _emotion;
  bool _isProcessing = false;

  Future<void> _captureImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        _isProcessing = true;
        _emotion = null;
      });

      await _detectEmotion(photo.path);
    }
  }

  Future<void> _detectEmotion(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        final face = faces.first;
        final smilingProb = face.smilingProbability ?? 0;

        String detectedEmotion;
        String encouragement;

        if (smilingProb > 0.7) {
          detectedEmotion = 'Happy 😊';
          encouragement = 'Great! Keep up that positive energy!';
        } else if (smilingProb > 0.3) {
          detectedEmotion = 'Neutral 😐';
          encouragement = 'You\'re doing well! Keep going!';
        } else {
          detectedEmotion = 'Sad 😔';
          encouragement =
              'It\'s okay to feel this way. Take a break if you need one!';
        }

        setState(() {
          _emotion = '$detectedEmotion\n\n$encouragement';
          _isProcessing = false;
        });
      } else {
        setState(() {
          _emotion = 'No face detected. Try again!';
          _isProcessing = false;
        });
      }
    } catch (e) {
      setState(() {
        _emotion = 'Error detecting emotion';
        _isProcessing = false;
      });
    }
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Detector'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'How are you feeling today?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (_image != null)
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: FileImage(_image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                if (_isProcessing)
                  const CircularProgressIndicator()
                else if (_emotion != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(_emotion!,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center),
                    ),
                  ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _captureImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Check My Mood'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
