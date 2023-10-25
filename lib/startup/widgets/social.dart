import 'package:flutter/material.dart';
import 'package:gafatcash/global.dart';
//import 'package:signin_signup/utils/global.colors.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            '- Or Signin with -',
            style: TextStyle(
                color: Global.whiteColor,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
        const SizedBox(height: 50,),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/svgs/g_logo.svg', height: 30,),
                ),
              ),
              const SizedBox(width: 10,),

              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/svgs/f_logo.svg', height: 30,),
                ),
              ),
              const SizedBox(width: 10,),

              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/svgs/g_logo.svg', height: 30,),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
