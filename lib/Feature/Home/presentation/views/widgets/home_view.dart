import 'package:chat_gpt_app_updated/Feature/ai_model/presentation/views/ai_send_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../chat_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}


class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/image/plant-growing-from-soil.png',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Text(
                  'Welcome Ahmed',
                  style: AppTextStyles.welcomeText,
                ),
                SizedBox(height: 8),
                Text(
                  'How I can help you',
                  style: AppTextStyles.subTitleText,
                ),
                SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _OptionCard(
                      iconPath: 'assets/image/AiIcon.svg',
                      label: 'ask our',
                      backgroundColor: AppColors.primaryGreen,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AiSendInfoView(),));
                      }, label2: 'Ai model',
                    ),
                    _OptionCard(
                      iconPath: 'assets/image/lucide_bot.svg',
                      label: 'Chat with',
                      backgroundColor: AppColors.darkGreen.withOpacity(0.8),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));
                      }, label2: 'Bot',
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/image/Logo.svg",height: 19,),
                    SizedBox(width: 7),
                    Text(
                      'Powered by PlantWise',
                      style: AppTextStyles.subTitleText.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String label2;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _OptionCard({
    required this.iconPath,
    required this.label,
    required this.backgroundColor,
    required this.onTap, required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        width: (MediaQuery.sizeOf(context).width * 0.5) - 20,
        child: AspectRatio(
          aspectRatio: 188 / 182,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffBCFF00).withOpacity(.17),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  label,

                  style: AppTextStyles.buttonText,
                ),
                Text(
                  label2,

                  style: AppTextStyles.buttonText.copyWith(fontWeight: FontWeight.w700,),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}

class AppColors {
  static const Color primaryGreen = Color(0xFF507f35);
  static const Color darkGreen = Color(0xFF1F2C26);
  static const Color white = Colors.white;
  static const Color transparentWhite = Colors.white70;
}

class AppTextStyles {
  static final TextStyle welcomeText = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static final TextStyle subTitleText = GoogleFonts.poppins(
    fontSize: 24,
    color: Colors.white
  );

  static final TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}
