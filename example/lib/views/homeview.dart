import 'package:android_media_store_example/views/albumlistview.dart';
import 'package:android_media_store_example/views/songlistview.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Songs"),
              Tab(text: "Albums"),
              Tab(text: "Artists"),
              Tab(text: "Genres"),
              Tab(text: "Playlists"),
            ]
          ),
          title: Text('MediaStore Demo'),
        ),
        body: TabBarView(
          children: [
            SongListView(),
            AlbumListView(),
            Text("Artists"),
            Text("Genres"),
            Text("Playlists")
          ],
        ),
      )
    );
  }
}