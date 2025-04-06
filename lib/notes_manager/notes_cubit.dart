
import 'package:flutter_bloc/flutter_bloc.dart';


import '../models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel> notes=[
    NoteModel(title: "Note1", body: "Task1"),
    NoteModel(title: "Note2", body: "Task2"),
    NoteModel(title: "Note3", body: "Task3"),
    NoteModel(title: "Note4", body: "Task4"),
    NoteModel(title: "Note5", body: "Task5"),
  ];


  getNotes() async{
    emit(GetNotesLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(GetNotesState(notes: notes));
  }

  addNote(NoteModel noteModel){
    notes.add(noteModel);
    emit(GetNotesState(notes: notes));
  }
 deleteNote(NoteModel noteModel){
    notes.remove(noteModel);
    emit(GetNotesState(notes: notes));
  }

// editNote(NoteModel noteModel, String newTitle, String newBody){
//     int index=notes.indexOf(noteModel);
//     if(index !=-1){
//       notes[index]= NoteModel(title: newTitle, body: newBody);
//       emit(GetNotesState(notes: notes));
//     }
//
// }
  editNote(NoteModel noteModel, String newTitle, String newBody) {
    int index = notes.indexOf(noteModel);
    if (index != -1) {
      notes[index] = NoteModel(title: newTitle, body: newBody);
      emit(GetNotesState(notes: List.from(notes))); // Force rebuild by creating a new list
    }
  }



}
