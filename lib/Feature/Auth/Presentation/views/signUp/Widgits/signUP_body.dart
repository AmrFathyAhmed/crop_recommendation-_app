
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/color.dart';
import '../../../../../../core/widget/dailog_message.dart';
import '../../../../../../core/widget/loading.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../OnBoarding/presentation/views/widgets/primary_button.dart';
import '../../../manager/sign_up_cubit/sign_up_cubit.dart';
import '../../../manager/sign_up_cubit/sign_up_state.dart';
import '../../login/Login_view.dart';
import '../../login/widgets/customTextField.dart';
import '../../login/widgets/custom_appbar.dart';
import '../../login/widgets/custom_bottom.dart';
import '../../login/widgets/lable_for_text_field.dart';

class SignUPBody extends StatelessWidget {
  const SignUPBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController nameController = TextEditingController();

    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();

    final TextEditingController confirmPasswordController =
        TextEditingController();
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          showDialog(
              context: context,
              builder: (context) => DialogMassage(
                    textColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    message: state.successMessage,
                    imageTitle: Assets.imageChecked,
                  ));
        } else if (state is SignUpFailure) {
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
      },
      builder: (context, state) {
        if (state is SignUpLoading) {
          return const CustomLoadingAnimation();
        } else {
          return Stack(

            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/image/AuthPG.png',
                  fit: BoxFit.cover,
                ),
              ),
            Container(
          height: MediaQuery.sizeOf(context).height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                            Text(
                              "Sign up",
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            CustomTextField(
                              hint: "Enter Full Name",
                              isPassword: false,
                              labelPass: "assets/image/user.svg",
                              controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name.';
                                }
                                return null;
                              }, label: 'Name',
                            ),

                            CustomTextField(
                              hint: "Enter Your Email",
                              isPassword: false,
                              labelPass: 'assets/image/sms.svg',
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email.';
                                }
                                return null;
                              }, label: 'Email',
                            ),

                            CustomTextField(
                              hint: "Enter Password",
                              isPassword: true,
                              labelPass: "assets/image/lock.svg",
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password.';
                                }
                                return null;
                              }, label: 'Password',
                            ),
                            Text(
                              "have an account? ",
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
                     SizedBox(height: 60),
                      PrimaryButton(


                          onPressed: () async {
                            _formKey.currentState?.save();
                            if (_formKey.currentState!.validate()) {
                              await BlocProvider.of<SignUpCubit>(context).signUp(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                              );
                            }
                          }, label: 'Sign up',),

                    ],
                  ),
                ),
              ),
            )],
          );
        }
      },
    );
  }
}
