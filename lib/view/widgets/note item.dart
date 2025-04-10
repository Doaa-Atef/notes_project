import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/view/widgets/add&update_note_bottom_sheet.dart';

import '../../notes_manager/notes_cubit.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.noteModel, required this.index});

  final NoteModel noteModel;
  final int index;

  @override
  Widget build(BuildContext context) {

        return Container(

          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),
            color: noteModel.isCritical?Colors.grey[500] : Colors.grey[300],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 25,
                child: Text(noteModel.id.toString(),
                  style: TextStyle(color: Colors.white,fontSize: 22),
                ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(noteModel.title!,style: TextStyle(fontSize: 18),),
                    Text(noteModel.body!,style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
              IconButton(onPressed: () async {
                showAddNoteBottomSheet(context: context,
                    isUpdate: true,
                    noteModel: noteModel,
                onSubmit: (String newTitle,String newBody,bool isCritical){
                  context.read<NotesCubit>().updateNote(noteModel: NoteModel(
                    id: noteModel.id,
                    title: newTitle,
                    body: newBody,
                    isCritical: isCritical,
                  ),);
                }

                );
              }, icon: Icon(Icons.edit, color: Colors.black,)),
              IconButton(onPressed: () async {
                await context.read<NotesCubit>().deleteNote(index: index);
              }, icon: Icon(Icons.delete, color: Colors.red,)),
            ],
          ),
        );

  }
}








