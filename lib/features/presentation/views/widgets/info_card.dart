import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String? text;
  final IconData? icon;
  Function()? onPressed;

  InfoCard({super.key, this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.blue,
          ),
          title: Text(
            text!,
            style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}
