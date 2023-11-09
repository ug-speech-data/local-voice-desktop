import 'package:flutter/material.dart';
import 'package:local_voice_desktop/pages/login_page.dart';
import 'package:local_voice_desktop/pages/menu_page.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Transcribed Audios:",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text("34",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text("Trans. Resolutions:",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text("100",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MenuPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.home_work),
                    ),
                    Text(
                      "Menu",
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Hi User!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
