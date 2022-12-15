import 'dart:core';

import 'package:contacts_app/database.dart';
import 'package:flutter/material.dart';

import '../fragments/avatar.dart';
import '../model/app_contact.dart';
import 'contact_details_view.dart';

class SearchView extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Database.searchContacts(query).isEmpty
        ? const Center(child: Text("No contacts!"))
        : ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            itemCount: Database.searchContacts(query).length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Contact contact = Database.searchContacts(query).elementAt(index);
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ContactDetailView(
                            contact: contact,
                            index: index,
                          )
                      )
                  );
                },
                leading: Avatar(
                  size: 30.0, image: contact.image,
                ),
                title: Text(contact.name),
              );
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search contacts'),
    );
  }
}
