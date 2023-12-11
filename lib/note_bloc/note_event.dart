part of 'note_bloc.dart';

@immutable
abstract class NoteEvent extends Equatable {}

class InitialEvent extends NoteEvent {
  @override
  List<Object?> get props => [];
}

class AddNoteEvent extends NoteEvent {
  final Note note;

  AddNoteEvent({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String key;

  DeleteNoteEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  UpdateNoteEvent({required this.note});

  @override
  List<Object?> get props => [note];
}