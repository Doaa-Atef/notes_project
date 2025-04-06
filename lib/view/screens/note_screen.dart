import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note_model.dart';
import 'package:notes/notes_manager/notes_cubit.dart';

import '../widgets/notes_list.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  TextEditingController titleController =TextEditingController();

  TextEditingController bodyController =TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void clearField(){
    bodyController.clear();
    titleController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Notes",
        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
      ),
      ),
      floatingActionButton:
      FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){
          showModalBottomSheet<void>
            (
              context: context, builder: (BuildContext bottomSheetContext)
             {
             return Container(
               margin: EdgeInsets.all(10),
               height: 350,
               child: Form(
                 key: _formKey,
                 child: Column(
                   spacing: 20,
                   children:<Widget> [
                     Text("Add Note",style: TextStyle(fontSize: 30,
                         fontWeight: FontWeight.bold),),
                     TextFormField(
                       controller: titleController,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         hintText: "Enter Title",
                       ),
                       validator: (value) {
                         if (value == null || value.trim().isEmpty) {
                           return "Please enter title";
                         }
                         return null;
                       },
                     ),
                     TextFormField(
                       controller: bodyController,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         hintText: "Enter Body",
                       ),
                       validator: (value) {
                         if (value == null || value.trim().isEmpty) {
                           return "Please enter body";
                         }
                         return null;
                       },
                     ),
                     ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.black,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10),
                           ),
                           minimumSize: Size(200,50),
                         ),
                         onPressed: (){
                           if (_formKey.currentState!.validate()) {
                             context.read<NotesCubit>().addNote(
                               NoteModel(
                                 title: titleController.text.trim(),
                                 body: bodyController.text.trim(),
                               ),
                             );
                             Navigator.pop(context);
                           };
                           clearField();
                         },
                         child: Text("Add Note",style: TextStyle(fontWeight: FontWeight.bold,
                     fontSize: 30,color: Colors.white),))
                   ],
                 ),
               ),
             );
             }
            );
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body:
      NotesList(),
    );
  }
}


