import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/storage/hive_init.dart';
import '../../../../core/utils/uuid_generator.dart';
import '../../../../core/utils/time_utils.dart';

class HomeworkHelperScreen extends StatefulWidget {
  const HomeworkHelperScreen({super.key});

  @override
  State<HomeworkHelperScreen> createState() => _HomeworkHelperScreenState();
}

class _HomeworkHelperScreenState extends State<HomeworkHelperScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _hint;
  bool _isProcessing = false;

  Future<void> _captureImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        _isProcessing = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _hint = 'Try breaking down the problem into smaller steps.\n\n'
            '1. Read the question carefully\n'
            '2. Identify what information you have\n'
            '3. Think about what operation to use\n'
            '4. Work through the problem step by step\n\n'
            'Remember: It\'s important to try solving it yourself first!';
        _isProcessing = false;
      });

      await _saveSubmission(photo.path);
    }
  }

  Future<void> _saveSubmission(String imagePath) async {
    final box = Hive.box(HiveBoxes.activityLog);
    final submission = {
      'id': UuidGenerator.generate(),
      'imagePath': imagePath,
      'hint': _hint,
      'submittedAtMs': TimeUtils.nowMs(),
    };
    await box.add(submission);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework Helper'),
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
                  'Take a photo of your homework question',
                  style: TextStyle(fontSize: 18),
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
                const SizedBox(height: 32),
                if (_isProcessing)
                  const CircularProgressIndicator()
                else if (_hint != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hint:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Text(_hint!, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _captureImage,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(_image == null ? 'Capture Image' : 'Take Another'),
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
