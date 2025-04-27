import 'package:flutter/material.dart';

import '../../../../../../core/color.dart';
import '../../../../../../generated/assets.dart';

class AppBarWithArrow extends StatelessWidget
{
  const AppBarWithArrow({Key? key, this.title="  ", this.onTap}) : super(key: key);
final String? title;
final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50 ,bottom: 28),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text("$title",style: TextStyle(fontSize: 18,),),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorSelect.SColor
                ),
                child: Image(image: AssetImage(Assets.imageArrowLeft),),
              ),
            )
          ],
        ),
      ),
    );
  }
}