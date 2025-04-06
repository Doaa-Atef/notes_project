import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/view/widgets/note%20item.dart';

import '../../notes_manager/notes_cubit.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if(state is GetNotesState)
        {
          return state.notes.isEmpty? Center(child:
          Text("No Notes",style: TextStyle(fontSize: 20),)):
          ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NoteItem(noteModel: state.notes[index],);

              });
        }
        else if(state is GetNotesLoadingState)
        {
          return Center(child: CircularProgressIndicator());
        }
        else {
          return Container();
        }

      },
    );
  }
}
