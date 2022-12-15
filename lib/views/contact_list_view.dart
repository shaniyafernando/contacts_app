import 'package:contacts_app/fragments/avatar.dart';
import 'package:contacts_app/views/contact_details_view.dart';
import 'package:contacts_app/views/search_view.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../model/app_contact.dart';
import 'contact_form_view.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {

  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactFormView(
                            editAction: false,
                            index: -1,
                            contact: null,
                          )));
            },
            icon: const Icon(Icons.add)),
        title: const Text('Contents Buddy'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchView());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 5.0),
              itemCount: Database.allContacts().length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context,int index) {
                Map contacts = Database.allContacts();
                Contact contact = contacts.values.elementAt(index);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ContactDetailView(
                              contact: contacts.values.elementAt(index),
                              index: index,
                            )
                        )
                    );
                  },
                  leading: Avatar(
                    image: contact.image,
                    size: 20.0,
                  ),
                  title: Text(contact.name),
                );
        }
      )
    );
  }
}
