import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/firebase_helper/firebase_auth_helper.dart';
import 'package:ecommerce/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newPassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: "New Password",
                prefixIcon: Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                )),
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: confirmPassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.password_sharp),
                suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
              onPressed: () async {
                if (newPassword.text.isEmpty) {
                  showMessage("enter new password");
                } else if (confirmPassword.text.isEmpty) {
                  showMessage("confirm your password");
                } else if (confirmPassword.text == newPassword.text) {
                  FirebaseAuthHelper.instance
                      .changePassword(newPassword.text, context);
                } else {
                  showMessage(
                      "confirm password must be same as new new password");
                }
              },
              title: "Update")
        ],
      ),
    );
  }
}
