import 'package:flutter/material.dart';

import '../widgets/category_button.dart';
import '../widgets/text_title.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String current = 'Economy';

  void onCategory(String value) {
    setState(() {
      current = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 34 + MediaQuery.of(context).viewPadding.top),
        const TextTitle('News'),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 14),
            CategoryButton(
              title: 'Economy',
              current: current,
              onPressed: () {
                onCategory('Economy');
              },
            ),
            const SizedBox(width: 16),
            CategoryButton(
              title: 'Analytics',
              current: current,
              onPressed: () {
                onCategory('Analytics');
              },
            ),
            const SizedBox(width: 16),
            CategoryButton(
              title: 'Statistics',
              current: current,
              onPressed: () {
                onCategory('Statistics');
              },
            ),
            const SizedBox(width: 14),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
