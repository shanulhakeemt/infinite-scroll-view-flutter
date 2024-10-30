import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_view/core/theme/app_pallete.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.onTap});
  final double height;
  final double width;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Pallete.whiteColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Pallete.backgroundColor),
          ),
        ),
      ),
    );
  }
}
