import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/nav/nav_bloc.dart';
import '../utils.dart';
import '../widgets/my_button.dart';
import '../widgets/svg_widget.dart';
import 'initial_screen.dart';
import 'income_screen.dart';
import 'news_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: navbarHeight),
            child: BlocConsumer<NavBloc, NavState>(
              listener: (context, state) {
                print(state.runtimeType);
              },
              builder: (context, state) {
                if (state is NavIncome) return const IncomeScreen();

                if (state is NavNews) return const NewsScreen();

                if (state is NavGame) return const GameScreen();

                return const InitialScreen();
              },
            ),
          ),
          const _NavBar(),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: navbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xff181818),
        ),
        child: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavBarButton(
                  id: 1,
                  title: 'Home',
                  active: state is NavInitial,
                ),
                _NavBarButton(
                  id: 2,
                  title: 'Income',
                  active: state is NavIncome,
                ),
                _NavBarButton(
                  id: 3,
                  title: 'News',
                  active: state is NavNews,
                ),
                _NavBarButton(
                  id: 4,
                  title: 'Game',
                  active: state is NavGame,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.id,
    required this.title,
    required this.active,
  });

  final int id;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: active
          ? null
          : () {
              context.read<NavBloc>().add(ChangePage(index: id));
            },
      padding: 0,
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            const SizedBox(height: 18),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? const Color(0xff4FB84F).withOpacity(0.2) : null,
              ),
              child: Center(
                child: SvgWidget(
                  'assets/$id.svg',
                  color: active ? const Color(0xff4FB84F) : Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                color: active ? const Color(0xff4FB84F) : Colors.white,
                fontSize: 12,
                fontFamily: 'w500',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
