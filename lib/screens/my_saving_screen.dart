import 'package:flutter/material.dart';

import '../widgets/field_title.dart';
import '../widgets/main_button.dart';
import '../widgets/my_button.dart';
import '../widgets/text_title.dart';
import '../widgets/txt_field.dart';

class MySavingScreen extends StatefulWidget {
  const MySavingScreen({super.key});

  @override
  State<MySavingScreen> createState() => _MySavingScreenState();
}

class _MySavingScreenState extends State<MySavingScreen> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  bool isActive = false;

  void checkActive() {
    setState(() {
      isActive = controller1.text.isNotEmpty && controller2.text.isNotEmpty;
    });
  }

  void onSave() async {
    if (mounted) Navigator.pop(context);
  }

  void onSelect(String value) {
    controller1.text = value;
    checkActive();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          const SizedBox(
            height: 60,
            child: TextTitle('My saving', back: true),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 70),
                const Row(
                  children: [
                    SizedBox(width: 14),
                    Text(
                      'Add saving',
                      style: TextStyle(
                        color: Color(0xff4FB84F),
                        fontSize: 22,
                        fontFamily: 'w500',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const FieldTitle('Category'),
                const SizedBox(height: 6),
                _Category(
                  category: controller1.text,
                  onSelect: onSelect,
                ),
                const SizedBox(height: 20),
                const FieldTitle('Amount'),
                const SizedBox(height: 6),
                TxtField(
                  controller: controller2,
                  hintText: '\$5000',
                  number: true,
                  length: 6,
                  onChanged: checkActive,
                ),
                const SizedBox(height: 10),
                MainButton(
                  title: 'Save',
                  isActive: isActive,
                  onPressed: onSave,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Category extends StatefulWidget {
  const _Category({
    required this.category,
    required this.onSelect,
  });

  final String category;
  final void Function(String) onSelect;

  @override
  State<_Category> createState() => _CategoryState();
}

class _CategoryState extends State<_Category> {
  bool expanded = false;
  String category = 'Short-term investments';

  List<String> categories = [
    'Short-term investments',
    'Long-term accounts',
    'Pension funds',
    'Contingency funds',
    'Investments in shares',
    'Deposits in banks',
    'Property',
    'Education',
    'Insurance ',
    'Mutual funds',
  ];

  void onCategory(String value) {
    widget.onSelect(value);
    setState(() {
      category = value;
      expanded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: const Color(0xff4FB84F),
            ),
          ),
          child: MyButton(
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'w500',
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: expanded ? 1 : 3,
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xff4FB84F),
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
        ),
        if (expanded)
          Container(
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: const Color(0xff4FB84F),
              ),
            ),
            child: Column(
              children: List.generate(
                categories.length,
                (index) {
                  return _CategoryText(
                    categories[index],
                    onCategory,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _CategoryText extends StatelessWidget {
  const _CategoryText(
    this.category,
    this.onSelect,
  );

  final String category;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {
        onSelect(category);
      },
      minSize: 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'w500',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
