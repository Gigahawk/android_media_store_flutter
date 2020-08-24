import 'package:android_media_store/android_media_store.dart';
import 'package:android_media_store_example/views/albumview.dart';
import 'package:android_media_store_example/views/songview.dart';
import 'package:flutter/material.dart';

class AlbumListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.of(context).size.width/2;
    final double itemHeight = itemWidth + 66;
    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.none &&
            !snapshot.hasData) {
          return Container();
        }
        if(snapshot.data != null) {
          List list = snapshot.data.toList();
          return GridView.builder(
            itemCount: list.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth/itemHeight)
            ),
            itemBuilder: (context, idx) {
              return AlbumView(list[idx]);
            },
          );
        }
        return Container();
      },
      future: AndroidMediaStore.albums,
    );
  }
}

