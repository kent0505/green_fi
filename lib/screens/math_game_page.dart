import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cash/cash_bloc.dart';
import '../models/answer.dart';
import '../models/math_quiz.dart';
import '../utils.dart';
import '../widgets/answer_card.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/field_title.dart';
import '../widgets/main_button.dart';
import '../widgets/score_card.dart';
import '../widgets/text_title.dart';

class MathGamePage extends StatefulWidget {
  const MathGamePage({super.key});

  @override
  State<MathGamePage> createState() => _MathGamePageState();
}

class _MathGamePageState extends State<MathGamePage> {
  int index = 0;
  int correctAnswers = 0;
  Answer selectedAnswer = Answer(
    answer: '',
    isCorrect: false,
  );

  void onAnswer(Answer value) {
    setState(() {
      selectedAnswer = value;
    });
  }

  void onCheck() async {
    final prefs = await SharedPreferences.getInstance();
    if (selectedAnswer.isCorrect) {
      score += 10;
      correctAnswers++;
    } else {
      score -= 10;
    }
    await prefs.setInt('score', score);
    if (mounted) {
      context.read<CashBloc>().add(GetCash());
    }
    if (index == 19) {
      if (mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return DialogWidget(
              title: 'Correct: $correctAnswers',
              onlyClose: true,
              onPressed: () {},
            );
          },
        ).then((value) {
          setState(() {
            index = 0;
            correctAnswers = 0;
            selectedAnswer = Answer(
              answer: '',
              isCorrect: false,
            );
            mathQuizes.shuffle();
            for (MathQuiz mathQuiz in mathQuizes) {
              mathQuiz.answers.shuffle();
            }
          });
        });
      }
    } else {
      setState(() {
        index++;
        selectedAnswer = Answer(
          answer: '',
          isCorrect: false,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mathQuizes.shuffle();
    for (MathQuiz mathQuiz in mathQuizes) {
      mathQuiz.answers.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          const SizedBox(
            height: 60,
            child: TextTitle('Maths quiz', back: true),
          ),
          const SizedBox(height: 4),
          const ScoreCard(),
          const SizedBox(height: 15),
          Container(
            height: 188,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xff1C1C1E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: const Color(0xff4FB84F),
              ),
            ),
            child: Center(
              child: Text(
                mathQuizes[index].question,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'w700',
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const FieldTitle('Enter your answer'),
          const SizedBox(height: 6),
          AnswerCard(
            id: 'A',
            current: selectedAnswer,
            answer: mathQuizes[index].answers[0],
            onPressed: onAnswer,
          ),
          const SizedBox(height: 14),
          AnswerCard(
            id: 'B',
            current: selectedAnswer,
            answer: mathQuizes[index].answers[1],
            onPressed: onAnswer,
          ),
          const SizedBox(height: 14),
          AnswerCard(
            id: 'C',
            current: selectedAnswer,
            answer: mathQuizes[index].answers[2],
            onPressed: onAnswer,
          ),
          const SizedBox(height: 14),
          AnswerCard(
            id: 'D',
            current: selectedAnswer,
            answer: mathQuizes[index].answers[3],
            onPressed: onAnswer,
          ),
          const SizedBox(height: 24),
          MainButton(
            title: 'Answer',
            isActive: selectedAnswer.answer.isNotEmpty,
            onPressed: onCheck,
          ),
        ],
      ),
    );
  }
}
