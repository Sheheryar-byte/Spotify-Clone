import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {

  final String buttontext;

  final VoidCallback ontap;

  const AuthGradientButton({super.key, required this.buttontext, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [

          Pallete.gradient1,
          Pallete.gradient2,


        ]),

        borderRadius: BorderRadius.circular(10)

      ),


      child: ElevatedButton(onPressed: ontap,
      
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        backgroundColor: Pallete.transparentColor,
        shadowColor: Pallete.transparentColor,
        
      ),
      
       child: Text(buttontext,
       style: const TextStyle(fontSize: 17,
       fontWeight: FontWeight.w600),)),
    );
  }
}