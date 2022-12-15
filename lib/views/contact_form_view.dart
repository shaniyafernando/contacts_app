import 'dart:io';

import 'package:contacts_app/database.dart';
import 'package:contacts_app/fragments/avatar.dart';
import 'package:contacts_app/fragments/button.dart';
import 'package:contacts_app/views/contact_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../model/app_contact.dart';


class ContactFormView extends StatefulWidget {
   final bool editAction;
   final int index;
  final Contact? contact;
  const ContactFormView({super.key, required this.contact,required this.index,required this.editAction});

  @override
  State<ContactFormView> createState() {
    return _ContactFormViewState();
  }
}

class _ContactFormViewState extends State<ContactFormView> {
  Database database = Database();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(mask: "### ### ####");

  XFile? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = XFile(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.editAction == true){
      _nameController.text = widget.contact?.name ?? '';
      _emailController.text = widget.contact?.email ?? '';
      _phoneNumberController.text = widget.contact?.phone ?? '';
    }

    @override
    void dispose() {
      _nameController.dispose();
      _emailController.dispose();
      _phoneNumberController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Avatar(image: image?.path, size: 80.0),
              const SizedBox(
                height: 50.0,
              ),
              Button(
                  buttonText: "Upload profile image",
                  buttonTapped: pickImage,
                  icon: Icons.camera_alt),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Name'),
                      ))),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Phone Number'),
                        inputFormatters: [maskFormatter],
                      ))),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                      ))),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                      buttonText: "Cancel",
                      buttonTapped: () {
                        Navigator.pop(context, const ContactListView());
                      },
                      icon: Icons.cancel),
                  const SizedBox(width: 20.0),
                  Button(
                      buttonText: "Save",
                      buttonTapped: ()  async{
                        if(_nameController.text.isNotEmpty
                            && _phoneNumberController.text.isNotEmpty
                            && _emailController.text.isNotEmpty && image != null){
                          Contact contact = Contact(
                            _nameController.text,
                            _phoneNumberController.text,
                            _emailController.text,
                            image?.path
                          );


                          if(widget.editAction == true){
                            Database.updateContact(contact, widget.index);
                            setState(() {});
                            Navigator.of(context).pop( const ContactListView());
                          } else {
                            Database.addContact(contact);
                            setState(() {});
                            Navigator.of(context).pop( const ContactListView());
                          }


                        }
                      },
                      icon: Icons.save),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
