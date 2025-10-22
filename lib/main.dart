import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/bloc/background_bloc.dart';
import 'logic/bloc/background_event.dart';
import 'presentation/screens/background_screen.dart';

void main() {
  runApp(const BackgroundGeneratorApp());
}

class BackgroundGeneratorApp extends StatefulWidget {
  const BackgroundGeneratorApp({super.key});

  @override
  State<BackgroundGeneratorApp> createState() => _BackgroundGeneratorAppState();
}

class _BackgroundGeneratorAppState extends State<BackgroundGeneratorApp> {
  late final BackgroundBloc _backgroundBloc;

  @override
  void initState() {
    super.initState();
    _backgroundBloc = BackgroundBloc();
    // Trigger initial pattern generation after the bloc is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get screen dimensions
      final screenSize = MediaQuery.of(context).size;
      _backgroundBloc.add(RegeneratePattern(
        width: screenSize.width,
        height: screenSize.height,
      ));
    });
  }

  @override
  void dispose() {
    _backgroundBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _backgroundBloc,
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