import 'package:hive/hive.dart';
import 'model/app_contact.dart';

class Database{

  static  initialize() async { await Hive.openBox<Contact>('contacts');}

  static Box contactsBox() => Hive.box<Contact>('contacts');

  static addContact(Contact newContact){ Database.contactsBox().add(newContact);}

  static Map allContacts(){ return Database.contactsBox().toMap();}

  static List searchContacts(String query){
    Map contacts = Database.contactsBox().toMap();

    return contacts.values.where((element) =>
    element.name.contains(query) ||
        element.email!.contains(query) ||
        element.phone.toString().contains(query)).toList();
  }

  static updateContact(Contact existingContact, int id){
    return Database.contactsBox().putAt(id, existingContact);
  }
  static deleteContact(int id){
    return Database.contactsBox().delete(id);
  }
}