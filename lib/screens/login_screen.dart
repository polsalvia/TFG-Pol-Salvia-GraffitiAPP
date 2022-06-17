import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graffitiapp/resources/auth_methods.dart';
import 'package:graffitiapp/responsive/mobile_screen_layout.dart';
import 'package:graffitiapp/responsive/responsive_layout_screen.dart';
import 'package:graffitiapp/responsive/web_screen_layout.dart';
// import 'package:graffitiapp/responsive/mobile_screen_layout.dart';
// import 'package:graffitiapp/responsive/responsive_layout_screen.dart';
// import 'package:graffitiapp/responsive/web_screen_layout.dart';
import 'package:graffitiapp/screens/signup_screen.dart';
import 'package:graffitiapp/utils/colors.dart';
import 'package:graffitiapp/utils/global_variables.dart';
import 'package:graffitiapp/utils/utils.dart';
import 'package:graffitiapp/widgets%20/text_field_input.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(); 
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          // padding: MediaQuery.of(context).size.width > WebScreenSize
          //     ? EdgeInsets.symmetric(
          //         horizontal: MediaQuery.of(context).size.width / 3)
          padding:   const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              //sgv image
              Flexible(
                child: Container(),
                flex: 2,                //mou el logo a baix
              ),
              SvgPicture.asset(
                'assets/GraffitiAPP_logo.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),


              
              //text input for email
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(   
                height: 24,
              ),



              //PASSWORD
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,  //distància entre les boxes de email i password
              ),



              //button login 
              InkWell(
                onTap: loginUser,
                child: Container(
                  
                   child: !_isLoading
                       ? const Text(
                           'Log in',
                         )
                       : const CircularProgressIndicator(
                           color: primaryColor,
                         ),
                  width: double.infinity,
                  alignment: Alignment.center,   //que estigui centrat 
                  padding: const EdgeInsets.symmetric(vertical: 12), 
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Colors.grey  //color del boto login 
                  ),
                ),
                //onTap: loginUser,
              ),



              //Transitioning to sign up
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      "Don't have an account?",
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(  //aquí indiquem que per onTap que es un toc de pantalla fagui el següent
                    // onTap: () => Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const SignupScreen(),   //que es anar a la pantalla de sign up
                    //   ),
                    // ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      
                      child: const Text(
                        ' Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}