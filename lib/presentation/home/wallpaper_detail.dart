import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterwallpaper/domain/entities/wallpaper.dart';
import 'package:flutterwallpaper/domain/repository/wallpaper_repository.dart';
import 'package:flutterwallpaper/presentation/providers/favourite_controller.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_list_notifier.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper/wallpaper.dart';

enum WallpaperType { Home, Lock, Both }

class WallaperDetailPage extends StatefulHookConsumerWidget {
  final int index;
  final int page;
  final String category;
  late PageController _scrollController;

  WallaperDetailPage(
      {key, required this.page, required this.category, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => WallaperDetailState();
}

bool downloading = false;
late Stream<String> progressString;
late String res;

class WallaperDetailState extends ConsumerState<WallaperDetailPage> {
  @override
  Widget build(BuildContext context) {
    widget._scrollController = PageController(initialPage: widget.index);
    final asyncValue =
        ref.watch(wallpaperListNotifierProvider(widget.category));

    MediaQueryData query;
    query = MediaQuery.of(context);
    return Scaffold(
      body: asyncValue.when(
        data: (wallpaperList) => PageView.builder(
          controller: widget._scrollController,
          itemCount: wallpaperList.length,
          itemBuilder: (context, index) {
            //bool isFav = _favController.isFavorite(wallpaperList[index]);
            return GestureDetector(
                onTap: () {
                  setState(() {
                    downloading = false;
                  });
                },
                child: Scaffold(
                  body: Stack(children: <Widget>[
                    SizedBox(
                      width: query.size.width,
                      height: query.size.height,
                      child: downloading
                          ? imageDownloadDialog()
                          : Hero(
                              tag: index.toString(),
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage('images/placeholder.png'),
                                image:
                                    NetworkImage(wallpaperList[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Align(
                      alignment: const Alignment(0.0, 0.0),
                      child: Center(
                          child: downloading
                              ? const SizedBox(
                                  height: 120.0,
                                  width: 200.0,
                                  child: Card(
                                    color: Colors.black,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircularProgressIndicator(),
                                        SizedBox(height: 20.0),
                                        Text(
                                          "Downloading File ",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : const Text("")),
                    ),
                    // Align(
                    //   alignment: const Alignment(1.0, 0.2),
                    //   child: FloatingActionButton(
                    //     heroTag: "fav",
                    //     backgroundColor:
                    //         const Color(0xFF010101).withOpacity(0.5),
                    //     onPressed: () async {
                    //       _favController
                    //           .addRemoveFavourites(wallpaperList[index]);
                    //     },
                    //     tooltip: 'Set Favourite Wallpaper',
                    //     child: Icon(
                    //       // Add the lines from here...
                    //       Icons.favorite,
                    //       color: isFav ? Colors.red : Colors.white,
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: const Alignment(1.0, 0.4),
                      child: FloatingActionButton(
                        heroTag: "one1",
                        backgroundColor:
                            const Color(0xFF010101).withOpacity(0.5),
                        onPressed: () async {
                          return await dowloadImage(
                              WallpaperType.Home,
                              context,
                              wallpaperList[index].potrait ??
                                  wallpaperList[index].large!);
                        },
                        tooltip: 'Set Home Screen',
                        child: const Icon(
                          // Add the lines from here...
                          Icons.home_filled,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.0, 0.6),
                      child: FloatingActionButton(
                        heroTag: "two2",
                        backgroundColor:
                            const Color(0xFF010101).withOpacity(0.5),
                        onPressed: () async {
                          return await dowloadImage(
                              WallpaperType.Lock,
                              context,
                              wallpaperList[index].potrait ??
                                  wallpaperList[index].large!);
                        },
                        tooltip: 'Set Lock Screen',
                        child: const Icon(
                          // Add the lines from here...
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.0, 0.8),
                      child: FloatingActionButton(
                        heroTag: "three3",
                        backgroundColor:
                            const Color(0xFF010101).withOpacity(0.5),
                        onPressed: () async {
                          return await dowloadImage(
                              WallpaperType.Both,
                              context,
                              wallpaperList[index].potrait ??
                                  wallpaperList[index].large!);
                        },
                        tooltip: 'Set Lock Screen',
                        child: const Icon(
                          // Add the lines from here...
                          Icons.wallpaper,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.0, 1),
                      child: FloatingActionButton(
                        backgroundColor:
                            const Color(0xFF010101).withOpacity(0.5),
                        heroTag: "three1",
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: 'Back',
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            color: Colors.white.withOpacity(0.5),
                            child: Text(
                              wallpaperList[index].photographer ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ))),
                  ]),
                ));
          },
        ),
        error: (_, __) => const Text('No wallpapers available.'),
        loading: () => Center(
            child: SpinKitSpinningLines(
                color: Theme.of(context).primaryColor, size: 250.0)),
      ),
    );
  }

  Future<void> dowloadImage(
      WallpaperType type, BuildContext context, String url) async {
    progressString = Wallpaper.imageDownloadProgress(url,
        location: DownloadLocation.APPLICATION_DIRECTORY);
    progressString.listen((data) {
      setState(() {
        res = data;
        downloading = true;
      });
    }, onDone: () async {
      setState(() {
        downloading = false;
      });

      switch (type) {
        case WallpaperType.Home:
          Wallpaper.homeScreen(
              location: DownloadLocation.APPLICATION_DIRECTORY);
          break;
        case WallpaperType.Lock:
          Wallpaper.lockScreen(
              location: DownloadLocation.APPLICATION_DIRECTORY);
          break;
        case WallpaperType.Both:
          Wallpaper.bothScreen(
              location: DownloadLocation.APPLICATION_DIRECTORY);
          break;
      }
    }, onError: (error) {
      setState(() {
        downloading = false;
      });
    });
  }

  Widget imageDownloadDialog() {
    return SizedBox(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
            Text(
              "Downloading File : $res",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
