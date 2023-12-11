import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../note_bloc/note_bloc.dart';
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
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Hello, add your first note!',
                      style: TextStyle(
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