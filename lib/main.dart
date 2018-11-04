import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutterwallpaper/video_cell.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count;
  static int l = 0;
  StreamSubscription<QuerySnapshot> subscription2;
  List<DocumentSnapshot> wallpaperlist2;
  CollectionReference collectionReference2 =
      Firestore.instance.collection("wallpapers");
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpaperlist;
  CollectionReference collectionReference =
      Firestore.instance.collection("wallpapers").document("1").collection("1");
  var _isLoading = true;

  _fetchData() async {
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpaperlist = datasnapshot.documents;
        _isLoading = false;
      });
    });
  }

  _fetchData0() async {
    subscription2 = collectionReference2.snapshots().listen((datasnapshot) {
      setState(() {
        wallpaperlist2 = datasnapshot.documents;
      });
    });
    _fetchData();
  }

  _fetchData2() {
    count = wallpaperlist2.length;
    l = l + 1;
    var p = "$l";
    if (count > l) {
      collectionReference =
          Firestore.instance.collection("wallpapers").document(p).collection(p);
    } else {
      l = 0;
      collectionReference =
          Firestore.instance.collection("wallpapers").document(p).collection(p);
    }
    _fetchData();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _fetchData0();
  }

  @override
  void dispose() {
    subscription?.cancel();
    subscription2?.cancel();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SafeArea(
        child: Scaffold(
          //backgroundColor: const Color(0xFF010101).withOpacity(1.0),
          appBar: new AppBar(
            centerTitle: true,
            title: IconButton(
              icon: new Icon(Icons.navigate_next),
              onPressed: () {
                print("Reloading...");
                _fetchData2();
              },
            ),
            backgroundColor: const Color(0xFF010101).withOpacity(1.0),
          ),
          body: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(8.0),
                    crossAxisCount: 4,
                    itemCount: this.wallpaperlist != null
                        ? this.wallpaperlist.length
                        : 0,
                    itemBuilder: (context, i) {
                      String imgurl = wallpaperlist[i].data['url'];
                      return VideoCell(imgurl);
                    },
                    staggeredTileBuilder: (i) =>
                        StaggeredTile.count(2, i.isEven ? 2 : 3),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
          ),
        ),
      ),
    );
  }
}
