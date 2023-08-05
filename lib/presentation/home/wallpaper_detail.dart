import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterwallpaper/presentation/providers/wallpaper_list_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper/wallpaper.dart';

class WallaperDetailPage extends StatefulHookConsumerWidget {
  final int index;
  final int page;
  final String category;
  late PageController _scrollController;

  WallaperDetailPage(
      {super.key,
      required this.page,
      required this.category,
      required this.index});

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
            return GestureDetector(
                onTap: () {
                  setState(() {
                    downloading = false;
                  });
                },
                child: Scaffold(
                  body: Stack(children: <Widget>[
                    Hero(
                      tag: wallpaperList[index].medium ?? "",
                      child: SizedBox(
                          width: query.size.width,
                          height: query.size.height,
                          child: downloading
                              ? imageDownloadDialog()
                              : FadeInImage(
                                  placeholder: const AssetImage(
                                      'images/placeholder.png'),
                                  image: NetworkImage(
                                      wallpaperList[index].imageUrl),
                                  fit: BoxFit.cover,
                                )),
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
                    Align(
                      alignment: const Alignment(1.0, 0.7),
                      child: FloatingActionButton(
                        heroTag: "two1",
                        backgroundColor:
                            const Color(0xFF010101).withOpacity(0.5),
                        onPressed: () async {
                          return await dowloadImage(
                              context,
                              wallpaperList[index].potrait ??
                                  wallpaperList[index].large!);
                        },
                        tooltip: 'Set Wallpaper',
                        child: const Icon(
                          // Add the lines from here...
                          Icons.wallpaper,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.0, 0.4),
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

  Future<void> dowloadImage(BuildContext context, String url) async {
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

      Wallpaper.bothScreen(location: DownloadLocation.APPLICATION_DIRECTORY);
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

class DialogDemoItem extends StatelessWidget {
  const DialogDemoItem(
      {super.key,
      required this.icon,
      required this.color,
      required this.text,
      required this.onPressed});

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 0.0, color: color),
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 6.0, bottom: 6.0, top: 6.0),
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
