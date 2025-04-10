import 'package:notes/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  static Database? database;

  //Create DataBase

static  Future init() async {
   await openDatabase("notes.db",
  version: 3,
  onCreate: (db,version) async{
     await db.execute('''
  CREATE TABLE Notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    body TEXT
  )
''');
    print("table created");
  },
       onUpgrade: (db, oldVersion, newVersion) async {
         if (oldVersion < 3) {
           await db.execute('ALTER TABLE Notes ADD COLUMN isCritical INTEGER DEFAULT 0');
           print("Column isCritical added");
         }
       },

       onOpen: (db){
     database=db;
    print("database opened");
    }
  );
}
  static Future <List<NoteModel>> getNotes () async{
    List<Map> list = await database!.rawQuery("SELECT * FROM Notes");
    print(list);
    return list.map((e) => NoteModel.fromMap(e)).toList();
  }


static insertNote({required NoteModel noteModel}) async {
  await database!.insert("Notes",
      noteModel.toMap(),
  );
  print("note inserted");

}

static deleteNote({required int id}) async{
  try{
    await database!.delete("Notes",where: 'id=?',whereArgs: [id]);
    print("note deleted successfuly $id");
  }catch (e){
    print("e ===> $e");
  }

}

static updateNote({required NoteModel noteModel})async{
  try{
    await database!.update("Notes", noteModel.toMap(), where: "id=?", whereArgs: [noteModel.id]);
    print("Note updated successfully");

  }catch(e){
    print("e ==> $e");
  }
}
}