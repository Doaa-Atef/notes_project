import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/view/widgets/note%20item.dart';
import '../../notes_manager/notes_cubit.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NotesCubit, NotesState>(
      buildWhen: (previous, current) => current is GetNotesState || current is DeleteNoteSuccessState || current is AddNoteSuccessState ||
          current is UpdateNoteSuccessState ,
      builder: (context, state) {
        if (state is GetNotesLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        return context.read<NotesCubit>().notes.isEmpty && (state is GetNotesState || state is DeleteNoteSuccessState)?
            Center(
              child: Padding(padding: EdgeInsets.all(10),
              child: Text("You don't have any notes",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black,
              fontSize: 25,
                fontWeight: FontWeight.bold
              ),
              ),

              ),
            ):

          ListView.builder(
            itemCount: context.read<NotesCubit>().notes.length,
            itemBuilder: (context, index) {
              return NoteItem(noteModel: context.read<NotesCubit>().notes[index],index: index,);
            });


      },
    );
  }
}
