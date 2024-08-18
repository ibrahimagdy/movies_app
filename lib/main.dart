import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/view/auth/login_view.dart';
import 'package:movies_app/view/auth/register_screen.dart';
import 'package:movies_app/view/browse/widgets/genre_view.dart';
import 'package:movies_app/view/home/home_details/home_details_view.dart';
import 'package:movies_app/view/splash/splash_view.dart';
import 'core/theme/application_theme.dart';
import 'firebase_options.dart';
import 'layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeLayout.routeName: (context) => const HomeLayout(),
        GenreView.routeName: (context) => GenreView(),
        HomeDetailsView.routeName: (context) => HomeDetailsView(),
      },
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
