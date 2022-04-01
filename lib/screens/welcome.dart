import 'package:flutter/material.dart';
import 'screens.dart';

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
                Text(
                  'Tic Tac Toe',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: _height / 10,
                ),
                Image.asset(
                  'assets/xo.jpeg',
                ),
                SizedBox(
                  height: _height / 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Game.route);
                  },
                  child: const Text(
                    'Start a new game',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    primary: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
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
