import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/components/round_button.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ValueNotifier _obsecurePassword = ValueNotifier(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _emailController.dispose();
    _obsecurePassword.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.alternate_email_outlined),
                ),
                onFieldSubmitted: (value) {
                  Utils().fieldFocusChnage(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obsecurePassword.value,
                    focusNode: passwordFocusNode,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: InkWell(
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: _obsecurePassword.value
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined)),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * .1,
              ),
              RoundButton(
                title: "Login",
                loading: _authViewMode.isLoding,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils().flushBarErrorMessage(
                        "Please Enter the Email", context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils().flushBarErrorMessage(
                        "Please Enter the Password", context);
                  } else if (_passwordController.text.length < 6) {
                    Utils().flushBarErrorMessage(
                        "Please Enter 6 Digit Password", context);
                  } else {
                    Map data = {
                      "email": _emailController.text.toString(),
                      "password": _passwordController.text.toString()
                    };
                    _authViewMode.loginApi(data, context);
                    print("Api hint ");
                  }
                },
              ),
              SizedBox(
                height: height *.0085,
              ),
              TextButton(onPressed: () {
                Navigator.pushNamed(context, RoutesName.signup);

              }, child: const Text("Don't have an account? Sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
