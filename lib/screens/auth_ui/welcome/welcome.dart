import 'package:ecommerce/constants/assets_images.dart';
import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/screens/auth_ui/login/login.dart';
import 'package:ecommerce/screens/auth_ui/signup.dart';
import 'package:ecommerce/widgets/primary_button.dart';
import 'package:ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TopTitles(
                title: "Welcome",
                subtitle: "Shop from the comfort of your home."),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Image.asset(
                AssetsImages.instance.welcomeImage,
                scale: 3,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.facebook,
                        size: 40,
                        color: Colors.blue,
                      ),
                      onPressed: () {}),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.email_outlined,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(
                onPressed: () {
                  Routes.instance.push(Login(), context);
                },
                title: "Login"),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(onPressed: () {
              Routes.instance.push(SignUp(), context);
            }, title: "Sign Up")
          ],
        ),
      ),
    );
  }
}
