import 'package:buuk_test/core/base/cubit/device_info_cubit.dart';
import 'package:buuk_test/core/helpers/app_constants.dart';
import 'package:buuk_test/features/movie_list/presentation/cubit/movie_list_cubit.dart';
import 'package:buuk_test/features/movie_list/presentation/view/home_movie_list_screen.dart';
import 'package:buuk_test/navigation/navigation_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blueGrey,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MovieListCubit>()),
        BlocProvider(create: (_) => sl<DeviceInfoCubit>()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationCenter.navigatorKey,
        title: '',
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        showSemanticsDebugger: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: NavigationCenter.generateRoute,
        home: HomeMovieListScreen(),
      ),
    );
  }
}
