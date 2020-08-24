import 'package:android_media_store/android_media_store.dart';
import 'package:android_media_store_example/views/songview.dart';
import 'package:flutter/material.dart';

class SongListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.none &&
            !snapshot.hasData) {
          return Container();
        }
        if(snapshot.data != null) {
          List list = snapshot.data.toList();
          return ListView.builder(
            itemCount: list.length ?? 0,
            itemBuilder: (context, idx) {
              return SongView(list[idx]);
            },
          );
        }
        return Container();
      },
      future: AndroidMediaStore.songs,
    );
  }
}

