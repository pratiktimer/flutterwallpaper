import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwallpaper/firebase_options.dart';
import 'package:flutterwallpaper/injection_container.dart';
import 'package:flutterwallpaper/presentation/developer/developer_page.dart';
import 'package:flutterwallpaper/presentation/home/category_name_container.dart';
import 'package:flutterwallpaper/presentation/home/colors_container.dart';
import 'package:flutterwallpaper/presentation/home/image_color_conatiner.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'config/theme/app_themes.dart';
import 'presentation/home/category_container.dart';
import 'presentation/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const ProviderScope(child: HomeApp()));
}

class HomeApp extends HookConsumerWidget {
  const HomeApp({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ref.watch(themeProvider).selectedThemeMode,
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const MyApp(),
    );
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () => _onBackPress(context),
      child: const Scaffold(
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

  Future<bool> _onBackPress(BuildContext context) async {
    bool shouldPop = false;

    await showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              title: const Text("Do you wish to close the app ?"),
              cancelButton: CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Close"),
              ),
              message:
                  const Text("Have you reviewed the app on Playstore yet ?"),
              actions: <Widget>[
                CupertinoActionSheetAction(
                    child: const Text("Review now on Playstore"),
                    onPressed: () {
                      Navigator.pop(context);
                      LaunchReview.launch();
                    }),
                CupertinoActionSheetAction(
                  child: const Text("Connect with the Developer"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(CupertinoPageRoute(
                        maintainState: true,
                        builder: (context) => new UserDeveloper()));
                  },
                ),
                CupertinoActionSheetAction(
                    child: const Text("Share the App"),
                    onPressed: () => Share.share(
                        "Hey! Check out this app on Playstore.Fluttery Wallpapers is a Wallpaper App . If you love the app please review the app on playstore and share it with your friends. https://play.google.com/store/apps/details?id=com.prateektimer.flutterwallpaper"))
              ],
            ));
    return shouldPop;
  }
}
