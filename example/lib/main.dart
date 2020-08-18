import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:android_media_store/android_media_store.dart';
import 'package:android_media_store/song.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  List<Song> _songs = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initSongList();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await AndroidMediaStore.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future initSongList() async {
    var songs = await AndroidMediaStore.songs;
    setState(() {
      _songs = songs.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView.builder(
          itemCount: _songs.length ?? 0,
          itemBuilder: (context, idx) {
            var song = _songs[idx];
            return Column(
              children: [
                Text(song.title),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.none &&
                    !snapshot.hasData) {
                      return Text('no album data');
                    }
                    return Text(snapshot.data?.name ?? 'album data was null');
                  },
                  future: song.artist,
                )
              ],
            );
        }),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await Permission.storage.request();
              print("Pressed");
              var songs = await AndroidMediaStore.songs;
              print(songs);
            },
            label: Text("Allow Storage")),
      ),
    );
  }
}
