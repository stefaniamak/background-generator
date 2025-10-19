import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/bloc/background_bloc.dart';
import 'presentation/screens/background_screen.dart';

void main() {
  runApp(const BackgroundGeneratorApp());
}

class BackgroundGeneratorApp extends StatelessWidget {
  const BackgroundGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BackgroundBloc(),
      child: MaterialApp(
        title: 'Grid Background Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: const BackgroundScreen(),
      ),
    );
  }
}