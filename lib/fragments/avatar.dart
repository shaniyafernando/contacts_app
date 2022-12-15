import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/app_contact.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? image;
  const Avatar({Key? key,  required this.size, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  image != null
          ? CircleAvatar(
          radius: size, backgroundImage: XFileImage(XFile(image!)))
          : CircleAvatar(
          radius: size,
          backgroundColor: Colors.black45,
          child: Icon(Icons.perm_identity,
              size: size, color: Colors.indigo.shade200)
      ),
    );
  }
}
