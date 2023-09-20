import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tdd/application/bloc/user_bloc.dart';
import 'package:tdd/domain/db/user_db_service.dart';
import 'package:tdd/presentation/auth/sign_up_page.dart';
import 'package:tdd/presentation/todo_page.dart';
import 'package:tdd/presentation/video_player_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  UserDBService.registerAdapters();
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (context) => UserBloc())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          home: TodoPage(),
        );
      },
      designSize: const Size(375, 812),
    );
  }
}
