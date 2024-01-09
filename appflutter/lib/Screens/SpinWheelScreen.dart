import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:confetti/confetti.dart';

class SpinWheelScreen extends StatefulWidget {
  @override
  _SpinWheelScreenState createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  StreamController<int> selected = StreamController<int>();
  final items = <FortuneItem>[
    FortuneItem(child: Text('Nướng'), style: FortuneItemStyle(color: Colors.red)),
    FortuneItem(child: Text('Bún'), style: FortuneItemStyle(color: Colors.blue)),
    FortuneItem(child: Text('Gà'), style: FortuneItemStyle(color: Colors.green)),
    FortuneItem(child: Text('Vịt'), style: FortuneItemStyle(color: Colors.orange)),
    FortuneItem(child: Text('Lẩu'), style: FortuneItemStyle(color: Colors.purple)),
    FortuneItem(child: Text('Coffee'), style: FortuneItemStyle(color: Colors.brown)),
    FortuneItem(child: Text('Bánh'), style: FortuneItemStyle(color: Colors.teal)),
    FortuneItem(child: Text('Đồ hàn, gà rán'), style: FortuneItemStyle(color: Colors.indigo)),
    FortuneItem(child: Text('Chè'), style: FortuneItemStyle(color: Colors.amber)),
    FortuneItem(child: Text('Nem'), style: FortuneItemStyle(color: Colors.pink)),
  ];

  bool isSpinning = false;
  int selectedValue = Random().nextInt(10);
  bool showResultContainer = false;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 5));
    isSpinning = false; // Set the initial value
  }

  @override
  void dispose() {
    selected.close();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vòng quay lú lẫn',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.redAccent[100],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FortuneWheel(
              selected: selected.stream,
              items: items,
              onAnimationStart: () {
                setState(() {
                  isSpinning = true;
                  showResultContainer = false;
                });
              },
              onAnimationEnd: () {
                setState(() {
                  isSpinning = false;
                  showResultContainer = true;
                });
                // After the wheel finishes spinning, show the result popup and confetti
                _showResultPopup((items[selectedValue].child as Text).data.toString());
                _confettiController.play();
              },
            ),
            if (showResultContainer)
              Positioned(
                bottom: 16,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Quán: ${(items[selectedValue].child as Text).data}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.yellow[700]),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop((items[selectedValue].child as Text).data.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: Size(10, 40),
                        ),
                        child: Text(
                          'Lấy',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                if (!isSpinning) {
                  _spinWheel();
                }
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellowAccent[100],
                ),
                child: Center(
                  child: Text(
                    'Spin',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.50,
              numberOfParticles: 20,
              minBlastForce: 10,
              maxBlastForce: 100,
              //colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange],
            ),
          ],
        ),
      ),
    );
  }

  void _spinWheel() {
    selectedValue = Fortune.randomInt(0, items.length);
    setState(() {
      selected.add(selectedValue);
    });
  }

  void _showResultPopup(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          content: Text(
            '$result',
            style: TextStyle(fontSize: 30, color: Colors.yellow),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
