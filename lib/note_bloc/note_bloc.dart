import 'package:bcc_note_book/di/injection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../ui/note.dart';
import '../database/database.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {

  final NoteDatabase noteDatabase = locator<NoteDatabase>();

  NoteBloc() : super(NoteInitial()) {
    on<InitialEvent>((event, emit) async {
      final notes = await noteDatabase.getNotes();
      emit(NotesLoaded(notes: notes));
    });

    on<AddNoteEvent>((event, emit) async {
      await noteDatabase.addNote(event.note);
      final notes = await noteDatabase.getNotes();
      emit(NotesLoaded(notes: notes));
    });

    on<DeleteNoteEvent>((event, emit) async {
      await noteDatabase.deleteNote(event.key);
      final notes = await noteDatabase.getNotes();
      emit(NotesLoaded(notes: notes));
    });

    on<UpdateNoteEvent>((event, emit) async {
      await noteDatabase.updateNote(event.note);
      final notes = await noteDatabase.getNotes();
      emit(NotesLoaded(notes: notes));
    });
  }
}
