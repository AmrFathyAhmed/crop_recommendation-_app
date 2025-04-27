import 'package:chat_gpt_app_updated/Feature/Auth/Presentation/views/signUp/signUp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Auth/Presentation/views/login/Login_view.dart';
import '../widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:  Color(0xff00261C),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/image/welcomeBG.svg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              children: [
                // SizedBox(
                //   height: size.height * 0.55,
                //   width: double.infinity,
                //   child: Image.asset(
                //     'assets/image/OBBG.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "PlantWise",
                          style: GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Turn soil data into smart growing decisions",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          label: "Login",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              )),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          label: "Sign up",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              )),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
