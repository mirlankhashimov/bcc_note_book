import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../blocs/note_bloc.dart';
import 'note_item.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
        if (state is NotesLoaded && state.notes.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              return NoteItem(note: state.notes[index]);
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      AppLocalizations.of(context)!.add_first_note,
                      style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )),
              ],
            ),
          );
        }
      })
    ]));
  }
}
