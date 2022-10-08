import 'package:buuk_test/views/home_movie_list_screen.dart';
import 'package:buuk_test/views/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class NavigationCenter {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const String homeScreen = '/home-screen';
  static const String movieDetailScreen = '/movie_detail_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeMovieListScreen(),
          settings: const RouteSettings(
            name: homeScreen,
          ),
        );

      case movieDetailScreen:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: const RouteSettings(
            name: movieDetailScreen,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
