import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
    formkey.currentState!.validate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sign Up.',style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 30,),
          
              CustomField(hinttext: 'Name',controller: namecontroller,),
          
              const SizedBox(height: 15,),
          
          
              CustomField(hinttext: 'Email',controller: emailcontroller,),
          
              const SizedBox(height: 15,),
              
              CustomField(hinttext: 'Password', controller: passwordcontroller,


              isObscuretext: true,),
          
              const SizedBox(height: 20,),
          
              AuthGradientButton(buttontext: 'Sign Up',
              ontap: () {
                
              },),
          
              const SizedBox(height: 20,),
          
              RichText(text: TextSpan(text: 'Already have an account? ',style: Theme.of(context).textTheme.titleMedium,
              children: const [
                TextSpan(text: 'Sign In',style: TextStyle(
                  color: Pallete.gradient2,
                  fontWeight: FontWeight.bold,
                ))
              ]))
          
            ],
          ),
        ),
      ),
    );
  }
}