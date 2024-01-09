part of 'note_bloc.dart';

@immutable
abstract class NoteState extends Equatable {}

class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

class NotesLoaded extends NoteState {
  final List<Note> notes;

  NotesLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}