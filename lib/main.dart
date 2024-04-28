import 'package:bloc_api/features/logic/logic.dart';
import 'package:bloc_api/features/post/screen/post_screen.dart';
import 'package:bloc_api/features/service/service.dart';
import 'package:bloc_api/features/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    RestApiService service=RestApiService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogicalService>(
          create: (context) => LogicalService(service),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Bloc',
        home: HomeView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

