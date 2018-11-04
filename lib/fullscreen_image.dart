import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';

class FullScreenImagePage extends StatefulWidget {
  String img;
  FullScreenImagePage(this.img);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<FullScreenImagePage> {
  static const platform =
      const MethodChannel('prateektimer.com.wallpaper/wallpaper');
  bool downloading = false;
  var progressString = "";
  // Get battery level.
  String _setWallpaper = '';

  Future<Null> setWallpaper() async {
    Dio dio = Dio();
    try {
      var dir = await getTemporaryDirectory();
      print(dir);

      await dio.download(widget.img, "${dir.path}/myimage.jpeg",
          onProgress: (rec, total) {
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          print(progressString);
          if (progressString == "100%") {
            _setWallpaer();
          }
        });
      });
    } catch (e) {}

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
  }

  Future<Null> _setWallpaer() async {
    String setWallpaper;
    try {
      final int result =
          await platform.invokeMethod('setWallpaper', 'myimage.jpeg');
      setWallpaper = 'Wallpaer Updated....';
    } on PlatformException catch (e) {
      setWallpaper = "Failed to Set Wallpaer: '${e.message}'.";
    }
    setState(() {
      _setWallpaper = setWallpaper;
    });
  }

  final LinearGradient bg = new LinearGradient(
      colors: [new Color(0x10000000), new Color(0x30000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: IconButton(
          icon: new Icon(Icons.wallpaper),
          onPressed: () {
            print("Reloading...");
            setWallpaper();
          },
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: const Color(0xFF010101).withOpacity(1.0),
      ),
      backgroundColor: const Color(0xFF010101).withOpacity(1.0),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(gradient: bg),
          child: Stack(
            children: <Widget>[
              SafeArea(
                child: Align(
                  alignment: Alignment.center,

                  child:
                      Hero(tag: widget.img, child: Image.network(widget.img)),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.7),
                child:
                    Text(_setWallpaper, style: TextStyle(color: Colors.white,fontSize: 19.0,
                      fontFamily: 'helvetica_neue')),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[],
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.0),
                child: Center(
                    child: downloading
                        ? Container(
                            height: 120.0,
                            width: 200.0,
                            child: Card(
                              color: Colors.black,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20.0),
                                  Text(
                                    "Downloading File : $progressString",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Text("")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
