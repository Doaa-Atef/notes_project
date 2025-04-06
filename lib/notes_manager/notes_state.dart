part of 'notes_cubit.dart';


sealed class NotesState {}

final class NotesInitial extends NotesState {}

class GetNotesLoadingState extends NotesState{}

final class GetNotesState extends NotesState {

  final List<NoteModel> notes;

  GetNotesState ({required this.notes});
}

class AddNote extends NotesState {}

class DeleteNote extends NotesState {}

class EditNote extends NotesState{}


