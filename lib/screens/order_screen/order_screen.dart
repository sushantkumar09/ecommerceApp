import 'package:flutter/material.dart';

class OrdeScreen extends StatefulWidget {
  const OrdeScreen({Key? key}) : super(key: key);

  @override
  State<OrdeScreen> createState() => _OrdeScreenState();
}

class _OrdeScreenState extends State<OrdeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
