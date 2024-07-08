import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {

  final String hinttext;
  final TextEditingController controller;
  final bool isObscuretext;

  const CustomField({super.key, required this.hinttext, required this.controller, this.isObscuretext = false});


  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      decoration: InputDecoration(

        hintText: hinttext,
        
      ),

      validator: (val){
        if(val!.isEmpty){
          return "$hinttext is empty";
        }
        return null;
      },

      obscureText: isObscuretext,
      

    );
  }
}