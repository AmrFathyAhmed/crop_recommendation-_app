import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Home/presentation/views/widgets/home_view.dart';


class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key, required this.phLevel, required this.nitrogen, required this.phosphorus, required this.potassium, required this.temperature, required this.rainfall, required this.humidity, required this.Predict});
  final double phLevel;
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double temperature;
  final double rainfall;
  final double humidity;
  final String Predict;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff00261C),
      body: SafeArea(
        child: Stack(

          children: [

            // Positioned.fill(
            //   child: SvgPicture.asset(
            //     'assets/image/AuthBG.svg',
            //     fit: BoxFit.cover,
            //   ),
            // ),

            Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Details', style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/image/Group.svg',
                        width: screenWidth * 0.07,
                        height: screenWidth * 0.07,
                      ),
                    ),
                  ),
                ],
              ),
                SizedBox(height: 20),
                 DecisionCard(Predict:" $Predict",),
                SizedBox(height: 20),
                Text(
                  "The Data",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height:110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      DataCard(title: "PH", value: "$phLevel", imagePath: "assets/image/Rectangle.png"),
                      SizedBox(width: 10),
                      DataCard(title: "Temperature", value: "$temperature", imagePath: "assets/image/Rectangle.png"),
                      SizedBox(width: 10),
                      DataCard(title: "Nitrogen", value: "$nitrogen", imagePath: "assets/image/Rectangle.png"),
                      SizedBox(width: 10),
                      DataCard(title: "Potassium", value: "$potassium", imagePath: "assets/image/Rectangle.png"),
                      SizedBox(width: 10),
                      DataCard(title: "Phosphorus", value: "$phosphorus", imagePath: "assets/image/Rectangle.png"),
                      SizedBox(width: 10),
                      DataCard(title: "Humidity", value: "$humidity", imagePath: "assets/image/Rectangle.png"),
                      SizedBox(width: 10),
                      DataCard(title: "Rainfall", value: "$rainfall", imagePath: "assets/image/Rectangle.png"),

                    ],
                  ),
                ),
                SizedBox(height: 40),
                Center(child: const AccuracyCard()),

                CustomButton(
                  text: "Change Data",
                  onPressed: () {},
                ),
              ],
            ),
          ),]
        ),
      ),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF00FF00);
  static const Color background = Color(0xFF062E26);
  static const Color cardBackground = Color(0xFF0E3B34);
  static const Color accent = Color(0xFFCAFF00);
  static const Color textColor = Colors.white;
}


class DecisionCard extends StatelessWidget {
  const DecisionCard({super.key, required this.Predict});
final String Predict;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 400/270,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              "The right plant for your soil",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "A decision was made based on the data given",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.6)),
            )
            ,SizedBox(height: 30),
           Container(
             width: MediaQuery.sizeOf(context).width*.55,
             height:MediaQuery.sizeOf(context).width*.2 ,
             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
             decoration: BoxDecoration(
               border: Border.all(color: Color(0xffBCFF00)),
               borderRadius: BorderRadius.circular(10),
             ),
             child: Center(
               child: Text(
                 Predict,
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Color(0xffBCFF00),
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  final String title;
  final String value;
  final String imagePath;

  const DataCard({super.key, required this.title, required this.value, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            Text(value,
                style: TextStyle(
                  color:  Color(0xffBCFF00),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}


class AccuracyCard extends StatelessWidget {
  const AccuracyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width*.45,
      height:  MediaQuery.sizeOf(context).width*.24,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.6),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xffBCFF00),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "98%",
              style: GoogleFonts.poppins (color: Colors.black, fontSize: 14),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "correct decision",
            style: GoogleFonts.poppins (color: Colors.white.withOpacity(.8), fontSize: 16,fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width:MediaQuery.sizeOf(context).width*.49 ,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(

            backgroundColor: AppColors.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          child: Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              const Icon(Icons.arrow_outward, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
