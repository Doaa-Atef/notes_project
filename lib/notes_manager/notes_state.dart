part of 'notes_cubit.dart';


sealed class NotesState {}

final class NotesInitial extends NotesState {}

class GetNotesLoadingState extends NotesState{}

final class GetNotesState extends NotesState {

}

class GetNotesErrorState extends NotesState{
  final String message;
  GetNotesErrorState(this.message);
}

class AddNoteSuccessState extends NotesState {}




class DeleteNoteLoadingState extends NotesState {}

class DeleteNoteSuccessState extends NotesState {
  final String message;
  DeleteNoteSuccessState(this.message);
}
class DeleteNoteErrorState extends NotesState {
  final String message;
  DeleteNoteErrorState(this.message);
}

class UpdateNoteLoadingState extends NotesState{}

class UpdateNoteSuccessState extends NotesState{
  final String message;
  UpdateNoteSuccessState(this.message);
}

class UpdateNoteErrorState extends NotesState{
  final String message;
  UpdateNoteErrorState(this.message);

}




