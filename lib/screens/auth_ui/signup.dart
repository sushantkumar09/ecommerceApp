import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/firebase_helper/firebase_auth_helper.dart';
import 'package:ecommerce/screens/custom_bottom_bar.dart';
import 'package:ecommerce/screens/home/home.dart';
import 'package:ecommerce/widgets/primary_button.dart';
import 'package:ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  title: "Create Account",
                  subtitle: "Welcome to Ecommerce App"),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: Icon(Icons.phone_rounded),
                  ),
                ),
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
                    bool isValidate = signUpVaildation(
                        email.text, password.text, name.text, phone.text);
                    // debugPrint(email.text);
                    if (isValidate) {
                      bool isLogined = await FirebaseAuthHelper.instance.signUp(
                          name.text, email.text, password.text, context);
                      if (isLogined) {
                        Routes.instance.pushAndRemoveUntil(CustomBottomBar(), context);
                      }
                    }
                  },
                  title: "Create Account"),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text("Already have an account?"),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Login",
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
