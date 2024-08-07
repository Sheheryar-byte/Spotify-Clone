import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {

  final String hinttext;
  final TextEditingController? controller;
  final bool isObscuretext;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomField({super.key, required this.hinttext, required this.controller, this.isObscuretext = false,this.readOnly = false,this.onTap});


  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: onTap,
      readOnly: readOnly,
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