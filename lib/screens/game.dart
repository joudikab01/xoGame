import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  static const String route = '/game';
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool xTurn = false;
  int xScore = 0;
  int oScore = 0;
  int playedSpots = 0;
  List<String> gameBoard = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image:  AssetImage(
                      'assets/star.jpg',
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Player X',
                          style:  TextStyle(
                            color: Colors.white,
                            fontSize: 25
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          xScore.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                              fontSize: 30
                          ),
                        ),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Player O',
                          style:  TextStyle(
                            color: Colors.white,
                              fontSize: 25
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          oScore.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                              fontSize: 30
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: _height / 10,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => tapped(index),
                        child: Container(
                          decoration: BoxDecoration(
                            border: isBorder(index),
                          ),
                          child: Center(
                            child: AnimatedTextKit(
                              repeatForever: true,
                              pause: const Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  gameBoard[index],
                                  textStyle: const TextStyle(
                                      fontSize: 47.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  speed: const Duration(
                                    milliseconds: 1000,
                                  ),
                                  colors: [
                                    Colors.white,
                                    Colors.grey,
                                    Colors.black38,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: _height / 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: _height / 15,
                        width: _width / 2.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.black38,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25,
                              ),
                            ),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 4,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () => _clearBoard(),
                          child: const Text(
                            'Restart',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height / 15,
                        width: _width / 2.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.black38,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25,
                              ),
                            ),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 4,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () => _clearScoreBoard(),
                          child: const Text(
                            'Reset scores',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (xTurn && gameBoard[index] == '') {
        gameBoard[index] = 'X';
        playedSpots++;
        xTurn = !xTurn;
        _checkWinner();
      } else if (!xTurn && gameBoard[index] == '') {
        gameBoard[index] = 'O';
        playedSpots++;
        xTurn = !xTurn;
        _checkWinner();
      }
    });
  }

  Border? isBorder(int index) {
    if (index == 0) {
      return const Border(
        top: BorderSide.none,
        left: BorderSide.none,
        bottom: BorderSide(color: Colors.white),
        right: BorderSide(color: Colors.white),
      );
    } else if (index == 1) {
      return const Border(
        top: BorderSide.none,
        left: BorderSide(color: Colors.white),
        bottom: BorderSide(color: Colors.white),
        right: BorderSide(color: Colors.white),
      );
    } else if (index == 2) {
      return const Border(
        top: BorderSide.none,
        left: BorderSide(color: Colors.white),
        bottom: BorderSide(color: Colors.white),
        right: BorderSide.none,
      );
    } else if (index == 3) {
      return const Border(
          top: BorderSide(color: Colors.white),
          left: BorderSide.none,
          bottom: BorderSide(color: Colors.white),
          right: BorderSide(color: Colors.white));
    } else if (index == 4) {
      return const Border(
        top: BorderSide(color: Colors.white),
        left: BorderSide(color: Colors.white),
        bottom: BorderSide(color: Colors.white),
        right: BorderSide(color: Colors.white),
      );
    } else if (index == 5) {
      return const Border(
        top: BorderSide(color: Colors.white),
        left: BorderSide(color: Colors.white),
        bottom: BorderSide(color: Colors.white),
        right: BorderSide.none,
      );
    } else if (index == 6) {
      return const Border(
        top: BorderSide(color: Colors.white),
        left: BorderSide.none,
        bottom: BorderSide.none,
        right: BorderSide(color: Colors.white),
      );
    } else if (index == 7) {
      return const Border(
        top: BorderSide(color: Colors.white),
        left: BorderSide(color: Colors.white),
        bottom: BorderSide.none,
        right: BorderSide(color: Colors.white),
      );
    } else if (index == 8) {
      return const Border(
        top: BorderSide(color: Colors.white),
        left: BorderSide(color: Colors.white),
        bottom: BorderSide.none,
        right: BorderSide.none,
      );
    }
    return null;
  }

  void _checkWinner() {
    if (gameBoard[0] == gameBoard[1] &&
        gameBoard[0] == gameBoard[2] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
    }
    if (gameBoard[3] == gameBoard[4] &&
        gameBoard[3] == gameBoard[5] &&
        gameBoard[3] != '') {
      _showWinDialog(gameBoard[3]);
    }
    if (gameBoard[6] == gameBoard[7] &&
        gameBoard[6] == gameBoard[8] &&
        gameBoard[6] != '') {
      _showWinDialog(gameBoard[6]);
    }
    if (gameBoard[0] == gameBoard[3] &&
        gameBoard[0] == gameBoard[6] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
    }
    if (gameBoard[1] == gameBoard[4] &&
        gameBoard[1] == gameBoard[7] &&
        gameBoard[1] != '') {
      _showWinDialog(gameBoard[1]);
    }
    if (gameBoard[2] == gameBoard[5] &&
        gameBoard[2] == gameBoard[8] &&
        gameBoard[2] != '') {
      _showWinDialog(gameBoard[2]);
    }
    if (gameBoard[0] == gameBoard[4] &&
        gameBoard[0] == gameBoard[8] &&
        gameBoard[0] != '') {
      _showWinDialog(gameBoard[0]);
    }
    if (gameBoard[2] == gameBoard[4] &&
        gameBoard[2] == gameBoard[6] &&
        gameBoard[2] != '') {
      _showWinDialog(gameBoard[2]);
    } else if (playedSpots == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "\" " + winner + " \" is Winner!!!",
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Play Again",
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              TextButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        gameBoard[i] = '';
      }
    });
    playedSpots = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        gameBoard[i] = '';
      }
    });
    playedSpots = 0;
  }
}
