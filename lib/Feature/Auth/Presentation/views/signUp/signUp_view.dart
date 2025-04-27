import 'package:flutter/material.dart';

import 'Widgits/signUP_body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:  Color(0xff00261C),
      body:SignUPBody() ,
    );
  }
}
