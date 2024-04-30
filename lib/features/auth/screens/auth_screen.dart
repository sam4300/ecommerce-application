import 'package:ecommerce_application/common/widgets/custom_button.dart';
import 'package:ecommerce_application/common/widgets/custom_text_field.dart';
import 'package:ecommerce_application/constants/global_variables.dart';
import 'package:ecommerce_application/service/auth_servvice.dart';
import 'package:flutter/material.dart';

enum Auth { signUp, signIn }

class AuthScreen extends StatefulWidget {
  static const route = '/auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  Auth auth = Auth.signUp;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  void signUpUser() {
    authService.signUpUser(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  void signInUser() {
    authService.signInUser(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                tileColor: auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signUp,
                  groupValue: auth,
                  onChanged: (Auth? val) {
                    setState(
                      () {
                        auth = val!;
                      },
                    );
                  },
                ),
              ),
              if (auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: nameController, hintText: 'Name'),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: emailController, hintText: 'Email'),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: passwordController,
                            hintText: 'Password'),
                        const SizedBox(height: 10),
                        CustomButton(
                          onPressed: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          text: 'Sign up',
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signIn,
                  groupValue: auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      auth = val!;
                    });
                  },
                ),
              ),
              if (auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          onPressed: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                          text: 'Sign in',
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
