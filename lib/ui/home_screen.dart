import 'package:bcc_note_book/ui/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../note_bloc/note_bloc.dart';
import 'note_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoteBloc _noteBloc;

  @override
  void initState() {
    super.initState();
    _noteBloc = BlocProvider.of<NoteBloc>(context);
    _noteBloc.add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bcc third home work"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Note',
            onPressed: () {
              addNoteDialog();
            },
          ),
        ],
      ),
      body: const Notes(),
    );
  }

  void addNoteDialog() {
    final NoteBloc addNoteBlock = BlocProvider.of<NoteBloc>(context);
    showDialog(
        context: context,
        builder: (context) {
          var titleController = TextEditingController();
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            content: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Type the title',
                            labelText: 'Note Title'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final title = titleController.text;
                          final note = Note("", title);
                          if (title.isNotEmpty) {
                            addNoteBlock.add(AddNoteEvent(note: note));
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
