import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterwallpaper/core/resources/data_state.dart';
import 'package:flutterwallpaper/data/data_sources/remote/wallpaper_service.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:flutterwallpaper/firebase_options.dart';
import 'package:flutterwallpaper/injection_container.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'data/repository/wallpaper_repository_impl.dart';
import 'domain/entities/wallpaper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(body: Center(child: WallpaperListWidget())),
      ),
    );
  }
}
