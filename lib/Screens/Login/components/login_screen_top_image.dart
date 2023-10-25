import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          child: Column(
            children: [
            //  Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:  const BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                     
                    )
                  ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: null //Text(text,style: TextStyle(fontSize: 16,wordSpacing: 6),),
                    )
                ),
              ),
            ],
          ),
        ),
        const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
        ),
        SizedBox(height: defaultPadding * 2),
        const Row(
          children: [
            Spacer(),
            // Expanded(
            //   flex: 8,
            //   child: SvgPicture.asset("assets/icons/login.svg"),
            // ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}