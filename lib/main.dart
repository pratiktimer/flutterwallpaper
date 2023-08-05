import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterwallpaper/firebase_options.dart';
import 'package:flutterwallpaper/injection_container.dart';
import 'package:flutterwallpaper/presentation/home/category_name_container.dart';
import 'package:flutterwallpaper/presentation/home/colors_container.dart';
import 'package:flutterwallpaper/presentation/home/image_color_conatiner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'config/theme/app_themes.dart';
import 'presentation/home/category_container.dart';
import 'presentation/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MyApp(),
    );
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ref.watch(themeProvider).selectedThemeMode,
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              CategoryNamesContainer(),
              SizedBox(
                height: 10,
              ),
              ColorsConatiner(),
              SizedBox(
                height: 10,
              ),
              ImageColorConatiner(),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   style: Theme.of(context).textTheme.titleMedium,
              //   "Recommend",
              // ),
              SizedBox(
                height: 10,
              ),
              CategoryContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
