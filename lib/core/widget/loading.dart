import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../color.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key, this.size=200});
final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(

      child: LoadingAnimationWidget.staggeredDotsWave(

        color: Color(0xffBCFF00),
        size: size!,
      ),
    );
  }
}

