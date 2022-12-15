import 'package:hive/hive.dart';

part 'app_contact.g.dart';

@HiveType(typeId: 1)
class Contact {

  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String email;

  @HiveField(3)
  String? image;

  Contact(this.name, this.phone, this.email, this.image);
}