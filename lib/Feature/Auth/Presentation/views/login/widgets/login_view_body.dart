
import 'package:chat_gpt_app_updated/Feature/Auth/Presentation/views/login/widgets/customTextField.dart';
import 'package:chat_gpt_app_updated/Feature/Home/presentation/views/widgets/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/color.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/widget/dailog_message.dart';
import '../../../../../../core/widget/loading.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../OnBoarding/presentation/views/widgets/primary_button.dart';
import '../../../manager/login_cubit/login_cubit.dart';
import '../../../manager/login_cubit/login_state.dart';
import '../../signUp/signUp_view.dart';
import 'custom_appbar.dart';
import 'custom_bottom.dart';
import 'lable_for_text_field.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginSuccess) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(),));
      } else if (state is LoginFailure) {
        showDialog(
            context: context,
            builder: (context) => DialogMassage(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  message: state.errorMessage,
                  imageTitle: Assets.imageCancel,
                ));
      }
    }, builder: (context, state) {
      if (state is LoginLoading) {
        return CustomLoadingAnimation();
      } else {
        return SafeArea(
          child: Stack(
          
           children: [
             Positioned.fill(
               child: Image.asset(
                 'assets/image/AuthPG.png',
                 fit: BoxFit.cover,
               ),
             ),
             Container(
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                // gradient: RadialGradient(
                //   center: Alignment(0.0, -0.6),
                //   colors: [
                //     Color(0xFF0F3F2C),
                //     Color(0xFF002619),
                //   ],
                //   radius: 1.0,
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                SvgPicture.asset("assets/image/Logo.svg"),
              
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(.08),  // Stroke color
                            width: 1,             // Stroke thickness
                          ),
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            CustomTextField(
                              hint: 'Enter Your Email',
                              isPassword: false,
                              labelPass: "assets/image/sms.svg",
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email.';
                                }
                                return null;
                              }, label: 'Email',
                            ),
                            CustomTextField(
                              hint: 'Enter Your Password',
                              labelPass: "assets/image/lock.svg",
                              isPassword: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password.';
                                }
                                return null;
                              }, label: 'Password',
                            ),
                            Text(
                              "Don't have an account yet? ",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white70,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                              },
                              child: Text(
                                'Register Now',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Color(0xffBCFF00),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                     SizedBox(
                        height: MediaQuery.sizeOf(context).height*.23,
                      ),
                      PrimaryButton(
                          label: "Login",
              
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
              
                              await BlocProvider.of<LoginCubit>(context).login(
                                  emailController.text, passwordController.text);
                            }
                          }),
              
              

              
                    ],
                  ),
                ),
              ),
            )],
          ),
        );
      }
    });
  }
}