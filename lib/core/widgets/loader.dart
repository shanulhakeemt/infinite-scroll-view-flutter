import 'package:flutter/material.dart';
import 'package:infinite_scroll_view/core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: CircularProgressIndicator(
          color: Pallete.cardColor,
          backgroundColor: Pallete.whiteColor,
        ),
      ),
    );
  }
}
