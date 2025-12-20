import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/gradient_background.dart';

class AdminVideosScreen extends StatefulWidget {
  const AdminVideosScreen({super.key});

  @override
  State<AdminVideosScreen> createState() => _AdminVideosScreenState();
}

class _AdminVideosScreenState extends State<AdminVideosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _youtubeUrlController = TextEditingController();
  int _selectedGrade = 1;
  String? _selectedSubjectId;
  String? _editingVideoId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _youtubeUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveVideo() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSubjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a subject'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final gradeId = 'grade_$_selectedGrade';
      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(_selectedSubjectId)
          .collection('videos')
          .add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'youtubeUrl': _youtubeUrlController.text.trim(),
        'enabled': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      _descriptionController.clear();
      _youtubeUrlController.clear();
      setState(() => _selectedSubjectId = null);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving video: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateVideo() async {
    if (!_formKey.currentState!.validate() || _editingVideoId == null || _selectedSubjectId == null) return;

    try {
      final gradeId = 'grade_$_selectedGrade';
      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(_selectedSubjectId)
          .collection('videos')
          .doc(_editingVideoId)
          .update({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'youtubeUrl': _youtubeUrlController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      _descriptionController.clear();
      _youtubeUrlController.clear();
      setState(() {
        _editingVideoId = null;
        _selectedSubjectId = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating video: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteVideo(String gradeId, String subjectId, String videoId, String videoTitle) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Video'),
        content: Text('Are you sure you want to delete "$videoTitle"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .collection('videos')
          .doc(videoId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video deleted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _startEditing(String videoId, String subjectId, Map<String, dynamic> data) {
    setState(() {
      _editingVideoId = videoId;
      _selectedSubjectId = subjectId;
      _titleController.text = data['title'] ?? '';
      _descriptionController.text = data['description'] ?? '';
      _youtubeUrlController.text = data['youtubeUrl'] ?? '';
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingVideoId = null;
      _titleController.clear();
      _descriptionController.clear();
      _youtubeUrlController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Video Materials'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Video Material',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                key: ValueKey(_selectedGrade),
                initialValue: _selectedGrade,
                decoration: InputDecoration(
                  labelText: 'Grade (Year) *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: List.generate(5, (i) => i + 1)
                    .map((g) => DropdownMenuItem(
                          value: g,
                          child: Text('Year $g'),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  _selectedGrade = value!;
                  _selectedSubjectId = null;
                }),
              ),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('materials')
                    .doc('grade_$_selectedGrade')
                    .collection('subjects')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DropdownButtonFormField<String>(
                    key: ValueKey(_selectedSubjectId),
                    initialValue: _selectedSubjectId,
                    decoration: InputDecoration(
                      labelText: 'Subject *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: snapshot.data!.docs.map((doc) {
                      return DropdownMenuItem(
                        value: doc.id,
                        child: Text(doc['name'] ?? 'Unknown Subject'),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedSubjectId = value),
                    validator: (value) =>
                        value == null ? 'Please select a subject' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Video Title *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _youtubeUrlController,
                decoration: InputDecoration(
                  labelText: 'YouTube URL *',
                  hintText: 'https://www.youtube.com/watch?v=...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.video_library),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a YouTube URL';
                  }
                  if (!value!.contains('youtube.com') && !value.contains('youtu.be')) {
                    return 'Please enter a valid YouTube URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _editingVideoId == null ? _saveVideo : _updateVideo,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Text(_editingVideoId == null ? 'Save Video' : 'Update Video'),
                    ),
                  ),
                  if (_editingVideoId != null) ...[
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _cancelEditing,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Existing Videos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('materials')
                    .doc('grade_$_selectedGrade')
                    .collection('subjects')
                    .snapshots(),
                builder: (context, subjectsSnapshot) {
                  if (!subjectsSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (subjectsSnapshot.data!.docs.isEmpty) {
                    return const Text('No subjects found. Add subjects first.');
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subjectsSnapshot.data!.docs.length,
                    itemBuilder: (context, subjectIndex) {
                      final subjectDoc = subjectsSnapshot.data!.docs[subjectIndex];
                      final subjectData = subjectDoc.data() as Map<String, dynamic>;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ExpansionTile(
                          title: Text(
                            subjectData['name'] ?? 'Unknown Subject',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('materials')
                                  .doc('grade_$_selectedGrade')
                                  .collection('subjects')
                                  .doc(subjectDoc.id)
                                  .collection('videos')
                                  .orderBy('createdAt', descending: true)
                                  .snapshots(),
                              builder: (context, videosSnapshot) {
                                if (!videosSnapshot.hasData) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }

                                if (videosSnapshot.data!.docs.isEmpty) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text('No videos in this subject'),
                                  );
                                }

                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: videosSnapshot.data!.docs.length,
                                  separatorBuilder: (context, index) => const Divider(),
                                  itemBuilder: (context, videoIndex) {
                                    final videoDoc = videosSnapshot.data!.docs[videoIndex];
                                    final videoData = videoDoc.data() as Map<String, dynamic>;
                                    final isEditing = _editingVideoId == videoDoc.id;

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          videoData['title'] ?? 'Unknown',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(videoData['description'] ?? ''),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.blue),
                                              onPressed: () => _startEditing(videoDoc.id, subjectDoc.id, videoData),
                                              tooltip: 'Edit',
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () => _deleteVideo(
                                                'grade_$_selectedGrade',
                                                subjectDoc.id,
                                                videoDoc.id,
                                                videoData['title'] ?? 'Unknown',
                                              ),
                                              tooltip: 'Delete',
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
