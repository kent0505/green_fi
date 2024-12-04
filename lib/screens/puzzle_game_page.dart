import 'package:flutter/material.dart';

import '../widgets/score_card.dart';
import '../widgets/text_title.dart';

class PuzzleGamePage extends StatefulWidget {
  const PuzzleGamePage({super.key});

  @override
  State<PuzzleGamePage> createState() => _PuzzleGamePageState();
}

class _PuzzleGamePageState extends State<PuzzleGamePage> {
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
