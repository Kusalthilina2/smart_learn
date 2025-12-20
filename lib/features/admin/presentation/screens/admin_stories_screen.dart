import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/gradient_background.dart';

class AdminStoriesScreen extends StatefulWidget {
  const AdminStoriesScreen({super.key});

  @override
  State<AdminStoriesScreen> createState() => _AdminStoriesScreenState();
}

class _AdminStoriesScreenState extends State<AdminStoriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _pageTextController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _audioUrlController = TextEditingController();

  int _selectedGrade = 1;
  String? _selectedSubjectId;
  String? _editingStoryId;
  bool _isLoading = false;
  List<Map<String, dynamic>> _pages = [];

  void _addPage() {
    if (_pageTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter page text'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      final page = <String, dynamic>{'text': _pageTextController.text.trim()};

      if (_imageUrlController.text.trim().isNotEmpty) {
        page['imageUrl'] = _imageUrlController.text.trim();
      }

      if (_audioUrlController.text.trim().isNotEmpty) {
        page['audioUrl'] = _audioUrlController.text.trim();
      }

      _pages.add(page);

      _pageTextController.clear();
      _imageUrlController.clear();
      _audioUrlController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Page added! Total: ${_pages.length}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _saveStory() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSubjectId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a subject')));
      return;
    }
    if (_pages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one page')),
      );
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
          .collection('stories')
          .add({
            'title': _titleController.text.trim(),
            'subjectId': _selectedSubjectId,
            'grade': _selectedGrade,
            'pages': _pages,
            'enabled': true,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

      _titleController.clear();
      setState(() {
        _selectedSubjectId = null;
        _pages = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Story saved successfully!'),
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

  Future<void> _updateStory() async {
    if (!_formKey.currentState!.validate() || _editingStoryId == null || _selectedSubjectId == null) return;
    if (_pages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one page')),
      );
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
          .collection('stories')
          .doc(_editingStoryId)
          .update({
        'title': _titleController.text.trim(),
        'subjectId': _selectedSubjectId,
        'grade': _selectedGrade,
        'pages': _pages,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      setState(() {
        _editingStoryId = null;
        _selectedSubjectId = null;
        _pages = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Story updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating story: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteStory(String gradeId, String subjectId, String storyId, String storyTitle) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Story'),
        content: Text('Are you sure you want to delete "$storyTitle"?'),
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
          .collection('stories')
          .doc(storyId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Story deleted successfully!'),
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

  void _startEditing(String storyId, String subjectId, Map<String, dynamic> data) {
    setState(() {
      _editingStoryId = storyId;
      _selectedSubjectId = subjectId;
      _titleController.text = data['title'] ?? '';

      // Load all pages from the story
      if (data['pages'] != null && data['pages'] is List) {
        _pages = List<Map<String, dynamic>>.from(
          (data['pages'] as List).map((p) => Map<String, dynamic>.from(p)),
        );
      } else {
        _pages = [];
      }
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingStoryId = null;
      _titleController.clear();
      _pages = [];
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _pageTextController.dispose();
    _imageUrlController.dispose();
    _audioUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Stories'),
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
                          'Add New Story',
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
                            labelText: 'Story Title *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) => value?.isEmpty ?? true
                              ? 'Please enter a title'
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Add Pages',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: ${_pages.length}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _pageTextController,
                          decoration: InputDecoration(
                            labelText: 'Page Text *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter the story text for this page...',
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _imageUrlController,
                          decoration: InputDecoration(
                            labelText: 'Image URL (Optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'https://example.com/image.jpg',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _audioUrlController,
                          decoration: InputDecoration(
                            labelText: 'Audio URL (Optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'https://example.com/audio.mp3',
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _addPage,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add Page',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : (_editingStoryId == null ? _saveStory : _updateStory),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
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
                                  _editingStoryId == null ? 'Save Story' : 'Update Story',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    if (_editingStoryId != null) ...[
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
                const SizedBox(height: 32),
                const Text(
                  'Existing Stories',
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
                                    .collection('stories')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder: (context, storiesSnapshot) {
                                  if (!storiesSnapshot.hasData) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }

                                  if (storiesSnapshot.data!.docs.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text('No stories in this subject'),
                                    );
                                  }

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: storiesSnapshot.data!.docs.length,
                                    separatorBuilder: (context, index) => const Divider(),
                                    itemBuilder: (context, storyIndex) {
                                      final storyDoc = storiesSnapshot.data!.docs[storyIndex];
                                      final storyData = storyDoc.data() as Map<String, dynamic>;
                                      final isEditing = _editingStoryId == storyDoc.id;
                                      final pageCount = (storyData['pages'] as List?)?.length ?? 0;

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            storyData['title'] ?? 'Unknown',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text('$pageCount page${pageCount != 1 ? 's' : ''}'),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.blue),
                                                onPressed: () => _startEditing(storyDoc.id, subjectDoc.id, storyData),
                                                tooltip: 'Edit',
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _deleteStory(
                                                  'grade_$_selectedGrade',
                                                  subjectDoc.id,
                                                  storyDoc.id,
                                                  storyData['title'] ?? 'Unknown',
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
