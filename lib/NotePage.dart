import 'package:flutter/material.dart';
import 'Note.dart';
import 'NotesRepository.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final _notesRepo = NotesRepository();
  late var _notes = <Note>[];

  @override
  void initState() {
    super.initState();
    _notesRepo
        .initDB()
        .whenComplete(() => setState(() => _notes = _notesRepo.notes));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Notes'),
      icon: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(
            _notes[i].name,
          ),
          subtitle: Text(
            _notes[i].description,
          ),
        ),
      ),
      actions: [
        FloatingActionButton(
          onPressed: () => _showDialog(),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Future _showDialog() => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          final nameController = TextEditingController();
          final descController = TextEditingController();
          return AlertDialog(
            title: const Text('New note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await _notesRepo.addNote(
                    Note(
                      name: nameController.text,
                      description: descController.text,
                    ),
                  );
                  setState(() {
                    _notes = _notesRepo.notes;
                    Navigator.pop(context);
                  });
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
}
