import 'package:flutter/material.dart';
import 'package:notes/database/app_database.dart';

import 'app.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
   await AppDatabase.init();

  runApp(const MyApp());
}
