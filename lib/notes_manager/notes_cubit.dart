
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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


  getNotes(){
    emit(GetNotes(notes: notes));
  }





}
