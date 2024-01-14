import 'package:bcc_note_book/di/injection.dart';
import 'package:bcc_note_book/features/tasks/data/repositories/post_repository.dart';
import 'package:bcc_note_book/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../dvo/note.dart';
import '../../../../database/database.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabase noteDatabase = locator<NoteDatabase>();

  NoteBloc() : super(NoteInitial()) {
    on<InitialEvent>((event, emit) async {
      //final notes = await noteDatabase.getNotes();
      final posts = await getIt<PostRepository>().getPostsData();
      final mappedPosts = posts
          .map((post) => Note(post.id.toString(), post.title ?? ""))
          .toList();
      emit(NotesLoaded(notes: mappedPosts));
    });

    on<AddNoteEvent>((event, emit) async {
      //await noteDatabase.addNote(event.note);
      await getIt<PostRepository>().addPost(event.note);
      final posts = await getIt<PostRepository>().getPostsData();
      final mappedNotes = posts
          .map((post) => Note(post.id.toString(), post.title ?? ""))
          .toList();
      emit(NotesLoaded(notes: mappedNotes));
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
