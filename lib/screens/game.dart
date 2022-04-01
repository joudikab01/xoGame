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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _clearBoard(),
              child: const Text(
                'Restart',
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => tapped(index),
                    child: Container(
                      decoration: BoxDecoration(border: isBorder(index)),
                      child: Center(
                        child: Text(
                          gameBoard[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
      } else if (!xTurn && gameBoard[index] == '') {
        gameBoard[index] = 'O';
        playedSpots++;
        xTurn = !xTurn;
      }

      _checkWinner();
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
  }

  void _checkWinner() {
    // Checking rows
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

    // Checking Column
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

    // Checking Diagonal
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
            title: Text("\" " + winner + " \" is Winner!!!"),
            actions: [
              TextButton(
                child: Text("Play Again"),
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
            title: Text("Draw"),
            actions: [
              TextButton(
                child: Text("Play Again"),
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
