
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/database/app_database.dart';


import '../models/note_model.dart';

part 'notes_state.dart';

enum UndoActionType {
  add,
  delete,
  update,
}
class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel> notes=[];

  UndoActionType? lastActionType;
  NoteModel? lastAffectedNote;

  getNotes() async {
    print("get notes");
    emit(GetNotesLoadingState());

    try {

      notes = await AppDatabase.getNotes();
      print("notes loaded from cubit $notes");
      emit(GetNotesState());
    } catch (e) {
      emit(GetNotesErrorState(e.toString()));
      print("Error fetching notes: $e");
    }
  }


  insertNote({required NoteModel noteModel})async{
    await AppDatabase.insertNote(noteModel: noteModel);
    lastActionType=UndoActionType.add;
    lastAffectedNote=noteModel;
    emit(AddNoteSuccessState());
    await getNotes();

  }

  Future<void> deleteNote({required int index}) async {
    emit(DeleteNoteLoadingState());
    try {
    lastActionType=UndoActionType.delete;
    lastAffectedNote=notes[index];
      await AppDatabase.deleteNote(id: notes[index].id!);
      notes.removeAt(index);
      emit(DeleteNoteSuccessState("Note deleted successfully"));
    } catch (e) {
      emit(DeleteNoteErrorState(e.toString()));
    }
  }




  Future<void> updateNote({required NoteModel noteModel}) async {
    emit(UpdateNoteLoadingState());
    try {
      final oldNote=notes.firstWhere((note)=> note.id==noteModel.id);
      lastActionType=UndoActionType.update;
      lastAffectedNote=oldNote;
      await AppDatabase.updateNote(noteModel: noteModel);
      getNotes();
      emit(UpdateNoteSuccessState("Note updated successfully"));
    } catch (e) {
      emit(UpdateNoteErrorState(e.toString()));
      print("e ==> $e");
    }
  }

}
