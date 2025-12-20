import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/gradient_background.dart';

class AdminSubjectsScreen extends StatefulWidget {
  const AdminSubjectsScreen({super.key});

  @override
  State<AdminSubjectsScreen> createState() => _AdminSubjectsScreenState();
}

class _AdminSubjectsScreenState extends State<AdminSubjectsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _iconController = TextEditingController();
  final _colorController = TextEditingController();
  int _selectedGrade = 1;
  int _sortOrder = 1;
  bool _isLoading = false;

  String? _editingSubjectId;

  Future<void> _addSubject() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final gradeId = 'grade_$_selectedGrade';
      final subjectId = _nameController.text.trim().toLowerCase().replaceAll(' ', '_');

      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .set({
        'displayName': 'Year $_selectedGrade',
        'enabled': true,
        'sortOrder': _selectedGrade,
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(subjectId)
          .set({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'icon': _iconController.text.trim().isEmpty ? 'subject' : _iconController.text.trim(),
        'color': _colorController.text.trim().isEmpty ? '0xFF2196F3' : _colorController.text.trim(),
        'sortOrder': _sortOrder,
        'enabled': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _nameController.clear();
      _descriptionController.clear();
      _iconController.clear();
      _colorController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subject added successfully!'),
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
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateSubject() async {
    if (!_formKey.currentState!.validate() || _editingSubjectId == null) return;

    setState(() => _isLoading = true);

    try {
      final gradeId = 'grade_$_selectedGrade';

      await FirebaseFirestore.instance
          .collection('materials')
          .doc(gradeId)
          .collection('subjects')
          .doc(_editingSubjectId)
          .update({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'icon': _iconController.text.trim().isEmpty ? 'subject' : _iconController.text.trim(),
        'color': _colorController.text.trim().isEmpty ? '0xFF2196F3' : _colorController.text.trim(),
        'sortOrder': _sortOrder,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _nameController.clear();
      _descriptionController.clear();
      _iconController.clear();
      _colorController.clear();
      setState(() => _editingSubjectId = null);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subject updated successfully!'),
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
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteSubject(String gradeId, String subjectId, String subjectName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Subject'),
        content: Text('Are you sure you want to delete "$subjectName"? This will also delete all associated content (lessons, quizzes, etc.).'),
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
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subject deleted successfully!'),
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

  void _startEditing(String subjectId, Map<String, dynamic> data) {
    setState(() {
      _editingSubjectId = subjectId;
      _nameController.text = data['name'] ?? '';
      _descriptionController.text = data['description'] ?? '';
      _iconController.text = data['icon'] ?? '';
      _colorController.text = data['color'] ?? '';
      _sortOrder = data['sortOrder'] ?? 1;
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingSubjectId = null;
      _nameController.clear();
      _descriptionController.clear();
      _iconController.clear();
      _colorController.clear();
      _sortOrder = 1;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _iconController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Subjects'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                          'Add New Subject',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
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
                          onChanged: (value) => setState(() => _selectedGrade = value!),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Subject Name *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter a name' : null,
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
                          controller: _iconController,
                          decoration: InputDecoration(
                            labelText: 'Icon (optional)',
                            hintText: 'calculate, science, book, history_edu',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _colorController,
                          decoration: InputDecoration(
                            labelText: 'Color (optional)',
                            hintText: '0xFF2196F3',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _sortOrder.toString(),
                          decoration: InputDecoration(
                            labelText: 'Sort Order',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _sortOrder = int.tryParse(value) ?? 1,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : (_editingSubjectId == null ? _addSubject : _updateSubject),
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : Text(
                                          _editingSubjectId == null ? 'Add Subject' : 'Update Subject',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                ),
                              ),
                            ),
                            if (_editingSubjectId != null) ...[
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
                const SizedBox(height: 24),
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
                          'Existing Subjects',
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
                              .orderBy('sortOrder')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text('No subjects found for this grade'),
                                ),
                              );
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              separatorBuilder: (context, index) => const Divider(),
                              itemBuilder: (context, index) {
                                final doc = snapshot.data!.docs[index];
                                final data = doc.data() as Map<String, dynamic>;
                                final isEditing = _editingSubjectId == doc.id;

                                return Container(
                                  decoration: BoxDecoration(
                                    color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      data['name'] ?? 'Unknown',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(data['description'] ?? ''),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                          onPressed: () => _startEditing(doc.id, data),
                                          tooltip: 'Edit',
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => _deleteSubject(
                                            'grade_$_selectedGrade',
                                            doc.id,
                                            data['name'] ?? 'Unknown',
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
