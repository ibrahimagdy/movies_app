import 'package:flutter/material.dart';
import 'package:movies_app/view/browse/widgets/genre_view.dart';
import 'package:movies_app/view/home/home_details/home_details_view.dart';
import 'package:movies_app/view/splash/splash_view.dart';
import 'core/theme/application_theme.dart';
import 'layout/home_layout.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ApplicationTheme.theme,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        HomeLayout.routeName: (context) => const HomeLayout(),
        GenreView.routeName: (context) => GenreView(),
        HomeDetailsView.routeName: (context) => HomeDetailsView(),
      },
    );
  }
}
