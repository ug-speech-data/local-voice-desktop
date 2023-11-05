import 'package:flutter/material.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: navHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {},
              child: const Text("Hi User!",
                  style: TextStyle(
                    color: Colors.white,
                  ))),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
