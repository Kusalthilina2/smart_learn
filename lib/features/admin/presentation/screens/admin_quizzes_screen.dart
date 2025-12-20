import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/gradient_background.dart';

class AdminQuizzesScreen extends StatefulWidget {
  const AdminQuizzesScreen({super.key});

  @override
  State<AdminQuizzesScreen> createState() => _AdminQuizzesScreenState();
}

class _AdminQuizzesScreenState extends State<AdminQuizzesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();

  int _selectedGrade = 1;
  String? _selectedSubjectId;
  String? _editingQuizId;
  int _correctOptionIndex = 0;
  bool _isLoading = false;
  List<Map<String, dynamic>> _questions = [];

  void _addQuestion() {
    if (_questionController.text.trim().isEmpty ||
        _option1Controller.text.trim().isEmpty ||
        _option2Controller.text.trim().isEmpty ||
        _option3Controller.text.trim().isEmpty ||
        _option4Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all question fields'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _questions.add({
        'question': _questionController.text.trim(),
        'options': [
          _option1Controller.text.trim(),
          _option2Controller.text.trim(),
          _option3Controller.text.trim(),
          _option4Controller.text.trim(),
        ],
        'correctIndex': _correctOptionIndex,
      });

      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _option4Controller.clear();
      _correctOptionIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Question added! Total: ${_questions.length}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _saveQuiz() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSubjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a subject')),
      );
      return;
    }
    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one question')),
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
          .collection('quizzes')
          .add({
        'title': _titleController.text.trim(),
        'description': '',
        'questions': _questions,
        'enabled': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      setState(() {
        _selectedSubjectId = null;
        _questions = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz saved successfully!'),
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

  Future<void> _updateQuiz() async {
    if (!_formKey.currentState!.validate() || _editingQuizId == null || _selectedSubjectId == null) return;
    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one question')),
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
          .collection('quizzes')
          .doc(_editingQuizId)
          .update({
        'title': _titleController.text.trim(),
        'questions': _questions,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      setState(() {
        _editingQuizId = null;
        _selectedSubjectId = null;
        _questions = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating quiz: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteQuiz(String gradeId, String subjectId, String quizId, String quizTitle) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Quiz'),
        content: Text('Are you sure you want to delete "$quizTitle"?'),
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
          .collection('quizzes')
          .doc(quizId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz deleted successfully!'),
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

  void _startEditing(String quizId, String subjectId, Map<String, dynamic> data) {
    setState(() {
      _editingQuizId = quizId;
      _selectedSubjectId = subjectId;
      _titleController.text = data['title'] ?? '';

      // Load all questions from the quiz
      if (data['questions'] != null && data['questions'] is List) {
        _questions = List<Map<String, dynamic>>.from(
          (data['questions'] as List).map((q) => Map<String, dynamic>.from(q)),
        );
      } else {
        _questions = [];
      }
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingQuizId = null;
      _titleController.clear();
      _questions = [];
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Quizzes'),
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
                          'Add New Quiz',
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
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Quiz Title *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter a title' : null,
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
                              'Add Questions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: ${_questions.length}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _questionController,
                          decoration: InputDecoration(
                            labelText: 'Question',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _option1Controller,
                          decoration: InputDecoration(
                            labelText: 'Option 1',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _option2Controller,
                          decoration: InputDecoration(
                            labelText: 'Option 2',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _option3Controller,
                          decoration: InputDecoration(
                            labelText: 'Option 3',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _option4Controller,
                          decoration: InputDecoration(
                            labelText: 'Option 4',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          key: ValueKey(_correctOptionIndex),
                          initialValue: _correctOptionIndex,
                          decoration: InputDecoration(
                            labelText: 'Correct Answer',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(value: 0, child: Text('Option 1')),
                            DropdownMenuItem(value: 1, child: Text('Option 2')),
                            DropdownMenuItem(value: 2, child: Text('Option 3')),
                            DropdownMenuItem(value: 3, child: Text('Option 4')),
                          ],
                          onChanged: (value) => setState(() => _correctOptionIndex = value!),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _addQuestion,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add Question',
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
                          onPressed: _isLoading ? null : (_editingQuizId == null ? _saveQuiz : _updateQuiz),
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
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  _editingQuizId == null ? 'Save Quiz' : 'Update Quiz',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    if (_editingQuizId != null) ...[
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
                  'Existing Quizzes',
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
                                    .collection('quizzes')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder: (context, quizzesSnapshot) {
                                  if (!quizzesSnapshot.hasData) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }

                                  if (quizzesSnapshot.data!.docs.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text('No quizzes in this subject'),
                                    );
                                  }

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: quizzesSnapshot.data!.docs.length,
                                    separatorBuilder: (context, index) => const Divider(),
                                    itemBuilder: (context, quizIndex) {
                                      final quizDoc = quizzesSnapshot.data!.docs[quizIndex];
                                      final quizData = quizDoc.data() as Map<String, dynamic>;
                                      final isEditing = _editingQuizId == quizDoc.id;
                                      final questionCount = (quizData['questions'] as List?)?.length ?? 0;

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            quizData['title'] ?? 'Unknown',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text('$questionCount question${questionCount != 1 ? 's' : ''}'),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.blue),
                                                onPressed: () => _startEditing(quizDoc.id, subjectDoc.id, quizData),
                                                tooltip: 'Edit',
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _deleteQuiz(
                                                  'grade_$_selectedGrade',
                                                  subjectDoc.id,
                                                  quizDoc.id,
                                                  quizData['title'] ?? 'Unknown',
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
