import 'package:flutter/material.dart';

import '../widgets/category_button.dart';
import '../widgets/my_button.dart';
import '../widgets/svg_widget.dart';
import '../widgets/text_title.dart';
import 'history_screen.dart';
import 'my_saving_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 34 + MediaQuery.of(context).viewPadding.top),
        const TextTitle('Home'),
        const SizedBox(height: 20),
        const _BalanceCard(),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 14),
            CategoryButton(
              title: 'Transactions',
              current: 'Transactions',
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            CategoryButton(
              title: 'My saving',
              current: 'My saving',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MySavingScreen();
                    },
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            CategoryButton(
              title: 'History',
              current: 'History',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HistoryScreen();
                    },
                  ),
                );
              },
            ),
            const SizedBox(width: 14),
          ],
        ),
        const SizedBox(height: 26),
        const TextTitle('Finance'),
        const SizedBox(height: 20),
        const Row(
          children: [
            SizedBox(width: 14),
            _TaskManagerCard(income: true),
            SizedBox(width: 30),
            _TaskManagerCard(),
            SizedBox(width: 14),
          ],
        ),
        const SizedBox(height: 20),
        const TextTitle('News'),
        const SizedBox(height: 20),
        // 2 news
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xff1C1C1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: const Color(0xff4FB84F),
        ),
      ),
      child: const Row(
        children: [
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28),
                Text(
                  'Current Balance',
                  style: TextStyle(
                    color: Color(0xff4FB84F),
                    fontSize: 22,
                    fontFamily: 'w500',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$ 1,000.22',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'w600',
                  ),
                ),
              ],
            ),
          ),
          SvgWidget('assets/balance.svg'),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}

class _TaskManagerCard extends StatelessWidget {
  const _TaskManagerCard({
    this.income = false,
  });

  final bool income;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xff1C1C1E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 8),
                Container(
                  height: 32,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xff4FB84F).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: SvgWidget(
                        income ? 'assets/task2.svg' : 'assets/task.svg'),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  income ? 'Income' : 'Task\nmanager',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'w500',
                    height: 0.9,
                  ),
                ),
              ],
            ),
            SizedBox(height: income ? 6 : 12),
            Row(
              children: [
                const SizedBox(width: 14),
                if (income)
                  const Text(
                    '\$ 145.88',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'w700',
                    ),
                  )
                else
                  const Text(
                    'Make a budget',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'w700',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(width: 14),
                if (income)
                  const Text(
                    'Total incomes',
                    style: TextStyle(
                      color: Color(0xff939393),
                      fontSize: 16,
                      fontFamily: 'w500',
                    ),
                  )
                else
                  const Expanded(
                    child: Text(
                      'record income and expenses.',
                      style: TextStyle(
                        color: Color(0xff939393),
                        fontSize: 12,
                        fontFamily: 'w500',
                      ),
                    ),
                  ),
                const SizedBox(width: 14),
              ],
            ),
            const Spacer(),
            _SeeAll(income),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}

class _SeeAll extends StatelessWidget {
  const _SeeAll(this.income);

  final bool income;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {
        if (income) {
        } else {}
      },
      minSize: 28,
      child: Container(
        height: 28,
        width: 84,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: const Color(0xff4FB84F).withOpacity(0.2),
        ),
        child: const Center(
          child: Text(
            'See all',
            style: TextStyle(
              color: Color(0xff4FB84F),
              fontSize: 12,
              fontFamily: 'w500',
            ),
          ),
        ),
      ),
    );
  }
}