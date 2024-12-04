import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cash/cash_bloc.dart';
import 'bloc/nav/nav_bloc.dart';
import 'bloc/saving/saving_bloc.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavBloc()),
        BlocProvider(create: (context) => CashBloc()..add(GetCash())),
        BlocProvider(create: (context) => SavingBloc()..add(GetSaving())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          useMaterial3: false,
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}
