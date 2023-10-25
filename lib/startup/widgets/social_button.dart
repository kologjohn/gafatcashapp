import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gafatcash/global.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final double horizontalPadding;
  final VoidCallback onPressed;
  const SocialButton({super.key, required this.iconPath, required this.label, this.horizontalPadding=40, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        iconPath,
        width: 25,
        color: Global.whiteColor,
      ),
      label: Text(label,
        style: const TextStyle(
          color: Global.whiteColor,
          fontSize: 17,
        ),
      ),
      style: TextButton.styleFrom(
        padding:  EdgeInsets.symmetric(vertical: 15, horizontal: horizontalPadding),
        shape:  RoundedRectangleBorder(
          side: const BorderSide(
            color: Global.borderColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
