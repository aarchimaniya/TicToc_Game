import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class GameScreen extends StatefulWidget {
  final bool isFirstPlayer;

  GameScreen({required this.isFirstPlayer});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  int _scoreX = 0;
  int _scoreO = 0;
  String _winner = '';
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _currentPlayer = widget.isFirstPlayer ? 'X' : 'O';
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _resetBoard() {
    setState(() {
      _board = List.filled(9, '');
      _winner = '';
    });
  }

  void _handleTap(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner()) {
          _winner = _currentPlayer;
          if (_winner == 'X') {
            _scoreX++;
          } else {
            _scoreO++;
          }
          _confettiController.play(); // Play confetti animation
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] != '' &&
          _board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]]) {
        return true;
      }
    }
    return false;
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            _board[index],
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('$_scoreX',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Player', style: TextStyle(fontSize: 24)),
                  Text('$_scoreO',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 20),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: _buildGridItem,
                itemCount: 9,
                shrinkWrap: true,
              ),
              SizedBox(height: 20),
              if (_winner.isNotEmpty)
                Text(
                  '$_winner wins!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetBoard,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: Colors.orange,
                ),
                child: Text('Reset Board', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
