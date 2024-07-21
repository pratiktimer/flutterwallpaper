import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwallpaper/presentation/developer/offline_dev.dart';
import 'package:flutterwallpaper/presentation/developer/online_dev.dart';
import 'package:flutterwallpaper/presentation/providers/developer_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDeveloper extends StatefulHookConsumerWidget {
  const UserDeveloper();

  @override
  UserDeveloperState createState() {
    return UserDeveloperState();
  }
}

class UserDeveloperState extends ConsumerState<UserDeveloper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final developerState = ref.watch(developerProvider);

    return Scaffold(
      body: developerState.when(
          data: (developer) => developer.data == null
              ? OfflineDev()
              : OnlineDev(developer.data!),
          error: (_, __) => OfflineDev(),
          loading: () => Center(
                  child: SpinKitThreeBounce(
                size: 24.0,
                itemBuilder: (_, index) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                  );
                },
              ))),
    );
  }
}
