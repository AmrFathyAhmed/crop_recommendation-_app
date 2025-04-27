import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/color.dart';
import '../../../../../../core/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.isPassword,
      required this.labelPass,
      this.iconData,
      this.validator,
      this.onTap,
      this.onChanged,
      this.controller, required this.label})
      : super(key: key);
  final String hint;
  final String labelPass;
  final bool isPassword;
  final IconData? iconData;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String label;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12),
      child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(

            controller: widget.controller,
            onTap: widget.onTap,
            validator: widget.validator,
            onChanged: widget.onChanged,
            textAlign: TextAlign.left,
            decoration: InputDecoration(

                suffixIcon: SvgPicture.asset(
                  widget.labelPass,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),


                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                    borderSide: BorderSide(color: Colors.red)) ,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black)),
                hintText: widget.hint,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),),
                fillColor: Colors.white.withOpacity(0.05),
                filled: true,
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,

                ),
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 13,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            cursorColor: Colors.white,
            obscureText: widget.isPassword,



          ),
        ],
      ),
    );
  }
}
