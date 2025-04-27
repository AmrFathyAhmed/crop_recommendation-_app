import 'package:flutter/material.dart';

import '../color.dart';

class DialogMassage extends StatelessWidget {

  const DialogMassage({super.key, this.message, this.imageTitle,this.onTap, this.textColor=Colors.red});
  final String? message;
  final Color? textColor;
  final String? imageTitle;
  final void Function()? onTap;



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: ColorSelect.SColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("$imageTitle",width: 50,height: 50,),
              const  SizedBox(height: 35),
              Text(
                '$message',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const  SizedBox(height: 20),
              GestureDetector(
                onTap:onTap,
                child:  Text('Close',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: textColor),textAlign: TextAlign.left,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
