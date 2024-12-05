import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/main_button.dart';
import '../widgets/my_button.dart';
import '../widgets/score_card.dart';
import '../widgets/text_title.dart';

class PuzzleGamePage extends StatefulWidget {
  const PuzzleGamePage({super.key});

  @override
  State<PuzzleGamePage> createState() => _PuzzleGamePageState();
}

class _PuzzleGamePageState extends State<PuzzleGamePage> {
  final List<int> _tiles = List.generate(15, (index) => index + 1)..add(0);
  int emptyIndex = 15;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    final rand = Random();
    for (var i = _tiles.length - 1; i > 0; i--) {
      final j = rand.nextInt(i + 1);
      final temp = _tiles[i];
      _tiles[i] = _tiles[j];
      _tiles[j] = temp;
    }
    emptyIndex = _tiles.indexOf(0);
  }

  void _moveTile(int index) {
    final emptyRow = emptyIndex ~/ 4;
    final emptyCol = emptyIndex % 4;
    final targetRow = index ~/ 4;
    final targetCol = index % 4;

    if ((emptyRow == targetRow && (emptyCol - targetCol).abs() == 1) ||
        (emptyCol == targetCol && (emptyRow - targetRow).abs() == 1)) {
      setState(() {
        _tiles[emptyIndex] = _tiles[index];
        _tiles[index] = 0;
        emptyIndex = index;
        _checkWinCondition();
      });
    }
  }

  void _checkWinCondition() async {
    final winningTiles = List.generate(15, (index) => index + 1)..add(0);
    if (listEquals(_tiles, winningTiles)) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DialogWidget(
            title: 'You win!',
            onlyClose: true,
            onPressed: () {},
          );
        },
      ).then((value) {
        setState(() {
          _shuffle();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = MediaQuery.of(context).size.width - 40;
    final tileSize = (containerSize - 14) / 4 + 4;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          const SizedBox(
            height: 60,
            child: TextTitle('The puzzle master', back: true),
          ),
          const SizedBox(height: 4),
          const ScoreCard(),
          const SizedBox(height: 15),
          Center(
            child: SizedBox(
              width: containerSize,
              height: containerSize,
              child: Stack(
                children: List.generate(16, (index) {
                  final tile = _tiles[index];
                  final row = index ~/ 4;
                  final col = index % 4;

                  if (tile == 0) return const SizedBox.shrink();

                  return AnimatedPositioned(
                    left: col * tileSize,
                    top: row * tileSize,
                    duration: const Duration(milliseconds: 300),
                    child: MyButton(
                      onPressed: () => _moveTile(index),
                      child: Container(
                        width: tileSize,
                        height: tileSize,
                        color: Colors.redAccent,
                        child: Center(
                          child: Text(
                            '$tile',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const Spacer(),
          MainButton(
            title: 'Next',
            // isActive: controller.text.isNotEmpty,
            onPressed: () {},
          ),
          const SizedBox(height: 96),
        ],
      ),
    );
  }
}
