import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../blocs/note_bloc.dart';
import '../dvo/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
    return Card(
      margin: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: ListTile(
              title: Text(note.title ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                //Navigator.of(context).push(_createRoute(note));
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
                icon: const Icon(Icons.delete),
                tooltip: '',
                onPressed: () {
                  noteBloc.add(DeleteNoteEvent(key: note.id));
                }),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
                icon: const Icon(Icons.edit),
                tooltip: '',
                onPressed: () {
                  editNoteDialog(context, note);
                }),
          ),
        ],
      ),
    );
  }

  void editNoteDialog(BuildContext context, Note? note) {
    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
    showDialog(
        context: context,
        builder: (context) {
          var titleController = TextEditingController();
          titleController.text = note?.title ?? "";
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!.type_title,
                            labelText:
                                AppLocalizations.of(context)!.note_title),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final title = titleController.text;
                          final updateNote = Note(note?.id ?? "", title);
                          if (title.isNotEmpty) {
                            noteBloc.add(UpdateNoteEvent(note: updateNote));
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Text(AppLocalizations.of(context)!.update),
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
