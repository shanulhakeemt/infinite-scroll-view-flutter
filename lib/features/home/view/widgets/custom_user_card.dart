import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_view/core/theme/app_pallete.dart';

class CustomUserCard extends StatelessWidget {
  const CustomUserCard(
      {super.key, required this.height, required this.name, required this.age});

  final double height;
  final String name;
  final String age;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
          height: height,
          decoration: BoxDecoration(
              color: Pallete.secondoryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Name :  $name",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Pallete.whiteColor),
                ),
                Text(
                  "Age     :  $age",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Pallete.whiteColor),
                ),
              ],
            ),
          )),
    );
  }
}
