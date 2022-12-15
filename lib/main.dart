import 'package:contacts_app/database.dart';
import 'package:contacts_app/views/contact_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'model/app_contact.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Database.initialize();
  // await Hive.deleteBoxFromDisk('contact');
  runApp(  const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      darkTheme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark
      ),
      home: const ContactListView()
    );
  }
}

