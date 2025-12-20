import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/gradient_background.dart';

class AdminLessonsScreen extends StatefulWidget {
  const AdminLessonsScreen({super.key});

  @override
  State<AdminLessonsScreen> createState() => _AdminLessonsScreenState();
}

class _AdminLessonsScreenState extends State<AdminLessonsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  int _selectedGrade = 1;
  String? _selectedSubjectId;
  String? _editingLessonId;
  bool _isLoading = false;

  Future<void> _addLesson() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSubjectId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a subject')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final gradeId = 'grade_$_selectedGrade';
      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(_selectedSubjectId)
          .collection('lessons')
          .add({
            'title': _titleController.text.trim(),
            'description': _descriptionController.text.trim(),
            'contentBlocks': [
              {'type': 'text', 'content': _contentController.text.trim()},
            ],
            'enabled': true,
            'duration': 10,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

      _titleController.clear();
      _descriptionController.clear();
      _contentController.clear();
      setState(() => _selectedSubjectId = null);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lesson added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateLesson() async {
    if (!_formKey.currentState!.validate() || _editingLessonId == null || _selectedSubjectId == null) return;

    setState(() => _isLoading = true);

    try {
      final gradeId = 'grade_$_selectedGrade';
      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(_selectedSubjectId)
          .collection('lessons')
          .doc(_editingLessonId)
          .update({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'contentBlocks': [
          {'type': 'text', 'content': _contentController.text.trim()},
        ],
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      _descriptionController.clear();
      _contentController.clear();
      setState(() {
        _editingLessonId = null;
        _selectedSubjectId = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lesson updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating lesson: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteLesson(String gradeId, String subjectId, String lessonId, String lessonTitle) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lesson'),
        content: Text('Are you sure you want to delete "$lessonTitle"?'),
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
          .collection('lessons')
          .doc(lessonId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lesson deleted successfully!'),
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

  void _startEditing(String lessonId, String subjectId, Map<String, dynamic> data) {
    setState(() {
      _editingLessonId = lessonId;
      _selectedSubjectId = subjectId;
      _titleController.text = data['title'] ?? '';
      _descriptionController.text = data['description'] ?? '';

      // Extract content from contentBlocks
      if (data['contentBlocks'] != null && data['contentBlocks'] is List && (data['contentBlocks'] as List).isNotEmpty) {
        final firstBlock = (data['contentBlocks'] as List)[0];
        if (firstBlock is Map && firstBlock['content'] != null) {
          _contentController.text = firstBlock['content'];
        }
      }
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingLessonId = null;
      _titleController.clear();
      _descriptionController.clear();
      _contentController.clear();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Lessons'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add New Lesson',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
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
                              onChanged: (value) =>
                                  setState(() => _selectedSubjectId = value),
                              validator: (value) => value == null
                                  ? 'Please select a subject'
                                  : null,
                            );
                          },
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
                              .map(
                                (g) => DropdownMenuItem(
                                  value: g,
                                  child: Text('Year $g'),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(() {
                            _selectedGrade = value!;
                            _selectedSubjectId = null;
                          }),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Lesson Title *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter a title'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 2,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter a description'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _contentController,
                          decoration: InputDecoration(
                            labelText: 'Lesson Content *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter the main lesson content here...',
                          ),
                          maxLines: 8,
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter content'
                              : null,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : (_editingLessonId == null ? _addLesson : _updateLesson),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          _editingLessonId == null ? 'Add Lesson' : 'Update Lesson',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                ),
                              ),
                            ),
                            if (_editingLessonId != null) ...[
                              const SizedBox(width: 12),
                              SizedBox(
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: _cancelEditing,
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Existing Lessons',
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
                                    .collection('lessons')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder: (context, lessonsSnapshot) {
                                  if (!lessonsSnapshot.hasData) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }

                                  if (lessonsSnapshot.data!.docs.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text('No lessons in this subject'),
                                    );
                                  }

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: lessonsSnapshot.data!.docs.length,
                                    separatorBuilder: (context, index) => const Divider(),
                                    itemBuilder: (context, lessonIndex) {
                                      final lessonDoc = lessonsSnapshot.data!.docs[lessonIndex];
                                      final lessonData = lessonDoc.data() as Map<String, dynamic>;
                                      final isEditing = _editingLessonId == lessonDoc.id;

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            lessonData['title'] ?? 'Unknown',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(lessonData['description'] ?? ''),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.blue),
                                                onPressed: () => _startEditing(lessonDoc.id, subjectDoc.id, lessonData),
                                                tooltip: 'Edit',
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _deleteLesson(
                                                  'grade_$_selectedGrade',
                                                  subjectDoc.id,
                                                  lessonDoc.id,
                                                  lessonData['title'] ?? 'Unknown',
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
