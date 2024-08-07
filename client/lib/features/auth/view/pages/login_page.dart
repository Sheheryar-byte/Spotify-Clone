import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {

    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
    
  }


  @override
  Widget build(BuildContext context) {

    
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(authViewModelProvider,(prev,next){

      next?.when(data: (data) {

        

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomePage()),
        
        (_) => false);
      }, error: (error,st) {
         showSnackBar(context, error.toString());

        
      }, loading: () {});

    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading? const Loader() : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sign In.',
              
              
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 30,),
          
              
          
              
          
          
              CustomField(hinttext: 'Email',controller: emailcontroller,),
          
              const SizedBox(height: 15,),
              
              CustomField(hinttext: 'Password', controller: passwordcontroller,


              isObscuretext: true,),
          
              const SizedBox(height: 20,),
          
              AuthGradientButton(buttontext: 'Sign In',
              ontap: () async {

                if(formkey.currentState!.validate()){

                  ref.read(authViewModelProvider.notifier).loginUser( email: emailcontroller.text, password: passwordcontroller.text);

                }

                else{
                  showSnackBar(context, 'Missing Fields');
                }
                
              },),
          
              const SizedBox(height: 20,),
          
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()),);
                },
                child: RichText(text: TextSpan(text: 'Don\'t have an account? ',style: Theme.of(context).textTheme.titleMedium,
                children: const [
                  TextSpan(text: 'Sign Up',style: TextStyle(
                    color: Pallete.gradient2,
                    fontWeight: FontWeight.bold,
                  ))
                ])),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}