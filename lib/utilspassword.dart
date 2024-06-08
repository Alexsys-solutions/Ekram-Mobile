import 'package:flutter/material.dart';


Widget buildContainer() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
  
      Container(
        width: 75,
        height: 1,
        color: Colors.black,
      ),
      const SizedBox(width: 5),
    ],
  );
}

Widget buildCircleButton(String text, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),            
      ],
    );
  }






