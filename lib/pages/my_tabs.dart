import 'package:flutter/material.dart';

import '../Themes/app_color.dart';
class MyTabs extends StatelessWidget {
  final Color color;
  final String text;

  const MyTabs({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:120,
      height: 50,
      child: Text(
        this.text,style: TextStyle(color: Colors.white,fontSize: 14),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: this.color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ]
      ),
    );
  }
}
