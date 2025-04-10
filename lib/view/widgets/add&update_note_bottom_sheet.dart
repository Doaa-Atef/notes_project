import 'package:flutter/material.dart';
import '../../models/note_model.dart';

showAddNoteBottomSheet({
  required BuildContext context,
  bool isUpdate = false,
  NoteModel? noteModel,
  required Function(String title, String body, bool isCritical) onSubmit,
}) {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(text: noteModel?.title);
  TextEditingController bodyController = TextEditingController(text: noteModel?.body);
  bool isCritical = noteModel?.isCritical ?? false;

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bottomSheetContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                height: 400,
                child: Column(
                  children: <Widget>[
                    Text(
                      isUpdate ? 'Update Note' : 'Add Note',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (v) => v!.isEmpty ? "Please enter title" : null,
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter title",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(

                      validator: (v) => v!.isEmpty ? "Please enter body" : null,
                      keyboardType: TextInputType.text,
                      controller: bodyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter body",
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isCritical,
                          onChanged: (bool? value) {
                            setState(() {
                              isCritical = value ?? false;
                            });
                          },
                        ),
                        Text("Mark as Critical")
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(200, 50),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          onSubmit(titleController.text, bodyController.text, isCritical);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        isUpdate ? "Update Note" : "Add Note",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}




