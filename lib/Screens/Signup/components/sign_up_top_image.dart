import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Create New Account".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding),
        const Row(
          children: [
            Spacer(),
            // Expanded(
            //   flex: 8,
            //   child: SvgPicture.asset("assets/icons/signup.svg"),
            // ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
