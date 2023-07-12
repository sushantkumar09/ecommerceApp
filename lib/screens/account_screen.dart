import 'package:ecommerce/firebase_helper/firebase_auth_helper.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserService _userService = UserService();
  UserModel? _user;

  @override
  void initState() {
    // TODO: implement initState
    fetchUserInformation();
    super.initState();
  }

  void fetchUserInformation() async {
    UserModel? user = await _userService.getUserInformation();
    setState(() {
      _user = user;
    });
  }

  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _user!.image == null
                    ? Icon(
                        Icons.person_outline_rounded,
                        size: 150,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(_user!.image.toString()),
                        radius: 60,
                      ),
                Text(
                  // appProvider.getUserInformation.name==null?"no name":appProvider.getUserInformation.name,
                  _user != null ? _user!.name : "no name",

                  // "sushant21kumar",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _user != null ? _user!.email : "no email",
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  width: 150,
                  child: PrimaryButton(onPressed: () {}, title: "Edit Profile"),
                )
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text("Your order"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.favorite_outline),
                    title: const Text("Favourite"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.info_outline_rounded),
                    title: const Text("About us"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.contact_support_outlined),
                    title: const Text("Support"),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Log out"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    "Version 1.1",
                    style: TextStyle(fontSize: 15),
                  )
                  // ListTile(leading: Icon(Icons.shopping_bag),title: Text("Your order"),),
                ],
              ))
        ],
      ),
    );
  }
}
