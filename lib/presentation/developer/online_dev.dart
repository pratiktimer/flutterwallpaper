import 'package:flutter/material.dart';
import 'package:flutterwallpaper/domain/entities/developer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

_launchInstagram() async {
  var url = "https://www.instagram.com/prateek_timer/";
  var uri = Uri.parse(url);
  await launchUrl(uri);
}

_launchlinkedIn() async {
  var url = "https://www.linkedin.com/in/pratik-banawalkar-1b6aa4167/";
  var uri = Uri.parse(url);
  await launchUrl(uri);
}

_launchGit() async {
  var url = "https://github.com/pratiktimer";
  var uri = Uri.parse(url);
  await launchUrl(uri);
}

class OnlineDev extends StatelessWidget {
  final DeveloperEntity developer;
  const OnlineDev(this.developer, {key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FadeInImage.assetNetwork(
            image: developer.backGroundUrl,
            placeholder: 'images/user.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 150.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.8),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0,
                                        offset: const Offset(0.0, 2.0))
                                  ]),
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(developer.profileUrl),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 14.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      developer.name ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'google',
                          fontWeight: FontWeight.w800,
                          fontSize: 30.0),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Prateek_timer",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'google',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3.0, bottom: 14.0),
                      width: (MediaQuery.of(context).size.width - 40) / 1.5,
                      height: 2.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0)),
                    ),

                    //  SizedBox(height: 18.0,),
                    Text(
                      developer.myquote ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'google',
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(
                      height: 18.0,
                    ),
                    const Text(
                      "Profiles",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'google',
                          fontWeight: FontWeight.w800,
                          fontSize: 26.0),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white,
                          ),
                          onPressed: _launchInstagram,
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.github,
                            color: Colors.white,
                          ),
                          onPressed: _launchGit,
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.white,
                          ),
                          onPressed: _launchlinkedIn,
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
