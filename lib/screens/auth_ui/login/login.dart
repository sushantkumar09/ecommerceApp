import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/firebase_helper/firebase_auth_helper.dart';
import 'package:ecommerce/screens/auth_ui/signup.dart';
import 'package:ecommerce/screens/home/home.dart';
import 'package:ecommerce/widgets/primary_button.dart';
import 'package:ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: "Login", subtitle: "Welcome to Ecommerce App"),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                  child:TextFormField(
                    controller: email,

                    decoration: const InputDecoration(
                      hintText: "E-mail",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  )
                // child: TextFormField(
                //   controller: email,
                //   decoration: const InputDecoration(
                //     hintText: "E-mail",
                //     prefixIcon: Icon(Icons.email_outlined),
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: TextFormField(
                  controller: password,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password_sharp),
                      suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PrimaryButton(
                  onPressed: () async {
                    bool isValidate =
                        loginVaildation(email.text, password.text);
                    // debugPrint(email.text);
                    if (isValidate) {
                      bool isLogined = await FirebaseAuthHelper.instance
                          .login(email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(Home(), context);
                      }
                    }
                  },
                  title: "Login"),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text("Don't have an account?"),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Routes.instance.push(SignUp(), context);
                  },
                  child: Text(
                    "Create an account",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
