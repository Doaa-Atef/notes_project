import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/notes_manager/notes_cubit.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if(state is GetNotes)
            {
              return ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.notes[index].title),
                            Text(state.notes[index].body),
                          ],
                        )
                    );
                  });
            }
          else {
            return Container();
          }

        },
      ),
    );
  }
}
