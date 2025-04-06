import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/notes_manager/notes_cubit.dart';

class NoteItem extends StatelessWidget {
   NoteItem({super.key, required this.noteModel,});
final NoteModel noteModel;
  TextEditingController titleController =
  TextEditingController();
  TextEditingController bodyController =
  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade400,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(noteModel.title),
                Text(noteModel.body),
              ],
            ),
             Row(
               children: [
                 IconButton(
                   icon: Icon(Icons.edit, color: Colors.black),
                   onPressed: () {

                     showDialog(
                       context: context,
                       builder: (BuildContext dialogContext) {
                         titleController = TextEditingController(text: noteModel.title);
                         bodyController = TextEditingController(text: noteModel.body);
                         return AlertDialog(
                           title: Text("Edit Note",style: TextStyle(fontWeight: FontWeight.bold),),
                           content: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               TextFormField(controller: titleController, decoration: InputDecoration(labelText: "Title",),cursorColor: Colors.black,),
                               TextFormField(controller: bodyController, decoration: InputDecoration(labelText: "Body"),cursorColor: Colors.black,),
                             ],
                           ),
                           actions: [
                             TextButton(
                               onPressed: () {
                                 context.read<NotesCubit>().editNote(
                                   noteModel,
                                   titleController.text.trim(),
                                   bodyController.text.trim(),
                                 );
                                 Navigator.pop(dialogContext);
                               },
                               child: Text("Save",style: TextStyle(color: Colors.black),),
                             ),
                             TextButton(
                               onPressed: () => Navigator.pop(dialogContext),
                               child: Text("Cancel",style: TextStyle(color: Colors.black)),
                             ),
                           ],
                         );
                       },
                     );

                   },
                 ),

                 IconButton(onPressed :(){
                   context.read<NotesCubit>().deleteNote(noteModel);
                 }
                     , icon: Icon(Icons.delete_outline_rounded,color: Colors.red,)

                 ),
               ],
             )

          ],
        )
    );
  }
}
