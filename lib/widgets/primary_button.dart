import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const PrimaryButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed, child: Text(title)),
      ),
    );
  }
}
