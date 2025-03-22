part of 'notes_cubit.dart';


sealed class NotesState {}

final class NotesInitial extends NotesState {}


final class GetNotes extends NotesState {
  final List<NoteModel> notes;


  GetNotes ({required this.notes});
}


