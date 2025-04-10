import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/notes_manager/notes_cubit.dart';
import '../widgets/add&update_note_bottom_sheet.dart';
import '../widgets/notes_list.dart';
import '../widgets/pdf.dart';
import '../widgets/show_snackbar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {


  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesCubit, NotesState>(
      listener: (context, state) {

        final readCubit=context.read<NotesCubit>();

        if (state is AddNoteSuccessState) {
          showSnackBar(
            context: context,
            title: "Note Added",

            actionLabel: "Undo",
            onPressed: () {
              final actionType = readCubit.lastActionType;
              final note = readCubit.lastAffectedNote;

              if (note == null || actionType == null) return;

              if (actionType == UndoActionType.add) {
                final index = readCubit.notes.indexWhere((n) => n.id == note.id);
                if (index != -1) {
                  readCubit.deleteNote(index: index);
                }
              }
            },
          );
        }

        else if (state is UpdateNoteSuccessState) {
          showSnackBar(
            context: context,
            title: state.message,

            onPressed: () {
              final actionType = readCubit.lastActionType;
              final note = readCubit.lastAffectedNote;

              if (note == null || actionType == null) return;

              if (actionType == UndoActionType.update) {
               readCubit.updateNote(noteModel: note);
              }
            },
          );
        }


        else if (state is DeleteNoteSuccessState) {
          showSnackBar(
            context: context,
            title: state.message,

            actionLabel: "Undo",
            onPressed: () {
              final actionType = readCubit.lastActionType;
              final note = readCubit.lastAffectedNote;

              if (note == null || actionType == null) return;

              if (actionType == UndoActionType.delete) {
                readCubit.insertNote(noteModel: note);
              }
            },
          );
        }
        else if (state is DeleteNoteErrorState) {
          showSnackBar(
            context: context,
            title: state.message,

            onPressed: () {},
          );
        } else if (state is GetNotesErrorState) {
          showSnackBar(
            context: context,
            title: state.message,

            onPressed: () {},
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.black,
              heroTag: "addNote",
              onPressed: () {
                showAddNoteBottomSheet(
                  context: context,
                  onSubmit: (title, body, isCritical) {
                    context.read<NotesCubit>().insertNote(
                      noteModel: NoteModel(
                        title: title,
                        body: body,
                        isCritical: isCritical,
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add, color: Colors.white),
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              backgroundColor: Colors.black,
              heroTag: "printNotes",
              onPressed: () async {
                final notes = context.read<NotesCubit>().notes;
                if (notes.isNotEmpty) {
                  await PDFGenerator.printNotes(notes);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No notes to print")),
                  );
                }
              },
              child: Icon(Icons.print, color: Colors.white),
            ),

          ],
        ),
        body: Column(
          children: [
            Expanded(child: NotesList()),
          ],
        ),
      ),
    );
  }
}
