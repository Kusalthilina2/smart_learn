import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/utils/uuid_generator.dart';

class AdminFlashcardsScreen extends StatefulWidget {
  const AdminFlashcardsScreen({super.key});

  @override
  State<AdminFlashcardsScreen> createState() => _AdminFlashcardsScreenState();
}

class _AdminFlashcardsScreenState extends State<AdminFlashcardsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _frontController = TextEditingController();
  final _backController = TextEditingController();

  int _selectedGrade = 1;
  String? _selectedSubjectId;
  String? _editingDeckId;
  bool _isLoading = false;
  List<Map<String, dynamic>> _cards = [];

  void _addCard() {
    if (_frontController.text.trim().isEmpty ||
        _backController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill both front and back of the card'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _cards.add({
        'id': UuidGenerator.generate(),
        'front': _frontController.text.trim(),
        'back': _backController.text.trim(),
        'lastReviewedMs': 0,
        'nextReviewMs': 0,
        'repetitions': 0,
        'easeFactor': 2.5,
      });

      _frontController.clear();
      _backController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Card added! Total: ${_cards.length}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _saveDeck() async {
    if (!_formKey.currentState!.validate()) return;
    if (_cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one flashcard')),
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
          .collection('flashcard_decks')
          .add({
        'title': _titleController.text.trim(),
        'cards': _cards,
        'isCustom': false,
        'enabled': true,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      setState(() {
        _selectedSubjectId = null;
        _cards = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Flashcard deck saved successfully!'),
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

  Future<void> _updateDeck() async {
    if (!_formKey.currentState!.validate() || _editingDeckId == null || _selectedSubjectId == null) return;
    if (_cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one flashcard')),
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
          .collection('flashcard_decks')
          .doc(_editingDeckId)
          .update({
        'title': _titleController.text.trim(),
        'cards': _cards,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      setState(() {
        _editingDeckId = null;
        _selectedSubjectId = null;
        _cards = [];
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Flashcard deck updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating deck: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteDeck(String gradeId, String subjectId, String deckId, String deckTitle) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard Deck'),
        content: Text('Are you sure you want to delete "$deckTitle"?'),
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
          .collection('flashcard_decks')
          .doc(deckId)
          .delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Flashcard deck deleted successfully!'),
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

  void _startEditing(String deckId, String subjectId, Map<String, dynamic> data) {
    setState(() {
      _editingDeckId = deckId;
      _selectedSubjectId = subjectId;
      _titleController.text = data['title'] ?? '';

      // Load all cards from the deck
      if (data['cards'] != null && data['cards'] is List) {
        _cards = List<Map<String, dynamic>>.from(
          (data['cards'] as List).map((c) => Map<String, dynamic>.from(c)),
        );
      } else {
        _cards = [];
      }
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingDeckId = null;
      _titleController.clear();
      _cards = [];
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _frontController.dispose();
    _backController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Flashcards'),
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
                          'Add New Flashcard Deck',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Deck Title *',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter a title' : null,
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
                                labelText: 'Subject (Optional)',
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
                              'Add Flashcards',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: ${_cards.length}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _frontController,
                          decoration: InputDecoration(
                            labelText: 'Front (Question/Term)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter the question or term...',
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _backController,
                          decoration: InputDecoration(
                            labelText: 'Back (Answer/Definition)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Enter the answer or definition...',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _addCard,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Add Card',
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
                          onPressed: _isLoading ? null : (_editingDeckId == null ? _saveDeck : _updateDeck),
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
                                  _editingDeckId == null ? 'Save Deck' : 'Update Deck',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    if (_editingDeckId != null) ...[
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
                  'Existing Flashcard Decks',
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
                                    .collection('flashcard_decks')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder: (context, decksSnapshot) {
                                  if (!decksSnapshot.hasData) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }

                                  if (decksSnapshot.data!.docs.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text('No flashcard decks in this subject'),
                                    );
                                  }

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: decksSnapshot.data!.docs.length,
                                    separatorBuilder: (context, index) => const Divider(),
                                    itemBuilder: (context, deckIndex) {
                                      final deckDoc = decksSnapshot.data!.docs[deckIndex];
                                      final deckData = deckDoc.data() as Map<String, dynamic>;
                                      final isEditing = _editingDeckId == deckDoc.id;
                                      final cardCount = (deckData['cards'] as List?)?.length ?? 0;

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: isEditing ? Colors.blue.withValues(alpha: 0.1) : null,
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            deckData['title'] ?? 'Unknown',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text('$cardCount card${cardCount != 1 ? 's' : ''}'),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.blue),
                                                onPressed: () => _startEditing(deckDoc.id, subjectDoc.id, deckData),
                                                tooltip: 'Edit',
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red),
                                                onPressed: () => _deleteDeck(
                                                  'grade_$_selectedGrade',
                                                  subjectDoc.id,
                                                  deckDoc.id,
                                                  deckData['title'] ?? 'Unknown',
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
