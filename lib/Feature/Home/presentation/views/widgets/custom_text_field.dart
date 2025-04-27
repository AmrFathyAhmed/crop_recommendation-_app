import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget
{
  const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16)
          ,
          color: Color(0xff3f414e),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
               style: TextStyle(color: Colors.white,fontSize: 22),

                decoration: InputDecoration(

                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Color(0xff6a6c7b),fontWeight: FontWeight.w600,fontSize: 18),

                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor: Color(0xff3f414e),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),

                ),
              ),
            ),
            SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.send,color: Color(0xff6a6c7b),),
              onPressed: () async{
                }

            ),
          ],
        ),
      ),
    );
  }
}
