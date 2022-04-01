import 'package:flutter/material.dart';
import 'screens.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_button/animated_button.dart';

class Welcome extends StatelessWidget {
  static const String route = '/welcome';
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: _width,
            height: _height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/star.jpg',
                ),
              ),
            ),
          ),
          Positioned(
            right: _width / 4,
            top: _height / 8,
            child: Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Tic Tac Toe',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 500),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
                // Text(
                //   'Tic Tac Toe',
                //   style: TextStyle(color: Colors.white, fontSize: 30),
                // ),
                SizedBox(
                  height: _height / 10,
                ),
                CircleAvatar(
                  radius: 100,
                  child: Image.asset(
                    'assets/xo.jpeg',
                  ),
                ),
                SizedBox(
                  height: _height / 10,
                ),
                SizedBox(
                  width: _width / 2,
                  height: _height / 15,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Game.route);
                    },
                    child: const Text(
                      'Start a new game',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black38,
                      elevation: 10,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 4,
                      ),
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
