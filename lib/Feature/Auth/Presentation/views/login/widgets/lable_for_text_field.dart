import 'package:flutter/material.dart';

class LabelForTextField extends StatelessWidget {
  const LabelForTextField({Key? key, required this.name}) : super(key: key);
      final String name;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Container(
          alignment: Alignment.centerRight,
          child: Text(
       "$name",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                fontFamily: "Almarai"),
          )),
    );
  }
}
