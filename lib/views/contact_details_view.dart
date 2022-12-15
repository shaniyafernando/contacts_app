import 'package:contacts_app/fragments/avatar.dart';
import 'package:contacts_app/views/contact_form_view.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../fragments/button.dart';
import '../model/app_contact.dart';

class ContactDetailView extends StatefulWidget {
  final int index;
  final Contact contact;

  const ContactDetailView({Key? key, required this.contact, required this.index  }) : super(key: key);

  @override
  State<ContactDetailView> createState() => _ContactDetailViewState();
}

class _ContactDetailViewState extends State<ContactDetailView> {
  TextStyle titleStyle = TextStyle(
      color: Colors.indigo[400],
      fontWeight: FontWeight.w700
  );

  TextStyle contentStyle = const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.w700,
      fontSize: 20.0
  );



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
             Center(
              child: Avatar(image: widget.contact.image, size: 80.0,),
            ),
            const SizedBox(height: 50.0,),
            Text("Name", style: titleStyle ),
            Text(widget.contact.name ?? '', style: contentStyle),
            const SizedBox(height: 30.0,),
            Text("Phone Number" , style: titleStyle),
            Text(widget.contact.phone.toString(), style: contentStyle),
            const SizedBox(height: 30.0,),
            Text("Email", style: titleStyle),
            Text(widget.contact.email ?? '', style: contentStyle),
            const SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    buttonText: "Delete",
                    buttonTapped: () {
                      Database.deleteContact(
                        Database.allContacts().keys.elementAt(widget.index)
                      );
                      setState(() {});
                    },
                    icon: Icons.delete),
                const SizedBox(width: 20.0),
                Button(
                    buttonText: "Edit", buttonTapped: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          ContactFormView(editAction: true, index: widget.index,contact: widget.contact,)));
                }, icon: Icons.edit),
              ],
            )
          ],
        ),
      ),
    );
  }
}
