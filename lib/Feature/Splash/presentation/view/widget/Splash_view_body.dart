
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/color.dart';
import '../../../../../generated/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {


  late AnimationController animationController;
  late Animation<double> fadingAnimation;

  @override
  void initState() {
    super.initState();
    initFadingAnimation();
    goToNextView();

  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(color: ColorSelect.SColor,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FadeTransition(
              opacity: fadingAnimation,
              child: Container(color: Colors.white ,height: MediaQuery.of(context).size.height,child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SvgPicture.asset("assets/image/Group1000004736.svg",width: MediaQuery.of(context).size.width*.5,height: MediaQuery.of(context).size.width*.5  ,),
              ))),
        ],
      ),
    );
  }

//====================================================
  void initFadingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    fadingAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController);
    animationController.repeat(reverse: true);
    goToNextView();
  }

//==================================================================
  bool? isLogin;

  void goToNextView() {
    Future.delayed(const Duration(seconds: 3), () {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        isLogin = false;
      } else {
        isLogin = true;
      }
      Navigator.pushReplacementNamed(
        context,
        isLogin == false ? "LoginView" : "HomeView",
      );
    });
  }

}
