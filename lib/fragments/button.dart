import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function() buttonTapped;
  final IconData icon;
  const Button({Key? key, required this.buttonText, required this.buttonTapped, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
              color: Colors.indigo.shade100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.indigo.shade900,),
                    const SizedBox(width: 10.0),
                    Text(buttonText,
                      style: TextStyle(
                          color:  Colors.indigo.shade700,
                          fontSize: 20.0
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}