import 'package:flutter/material.dart';
import '../game_page/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFirstPlayer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pic Your Side',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ToggleButtons(
              borderColor: Colors.transparent,
              fillColor: Colors.transparent,
              selectedBorderColor: Colors.transparent,
              selectedColor: Colors.transparent,
              children: <Widget>[
                Column(
                  children: [
                    Icon(Icons.close,
                        color: isFirstPlayer ? Colors.orange : Colors.grey,
                        size: 100),
                    Text('First'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.circle,
                        color: !isFirstPlayer ? Colors.green : Colors.grey,
                        size: 100),
                    Text('Second'),
                  ],
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  isFirstPlayer = index == 0;
                });
              },
              isSelected: [isFirstPlayer, !isFirstPlayer],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GameScreen(isFirstPlayer: isFirstPlayer),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text('CONTINUE', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
