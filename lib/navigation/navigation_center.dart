import 'package:buuk_test/features/movie_list/presentation/view/home_movie_list_screen.dart';
import 'package:flutter/material.dart';

class NavigationCenter {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const String homeScreen = '/home-screen';
  static const String movieDetailScreen = '/movie_detail_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeMovieListScreen(),
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
