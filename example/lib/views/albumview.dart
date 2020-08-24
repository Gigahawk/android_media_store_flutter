import 'package:android_media_store/album.dart';
import 'package:android_media_store/song.dart';
import 'package:android_media_store/artist.dart';
import 'package:flutter/material.dart';

class AlbumView extends StatelessWidget {
  Album album;
  int rowSize;
  AlbumView(this.album, {this.rowSize: 2});

  static const TextStyle accentStyle = TextStyle(
    color: Colors.grey
  );


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: 20,
              color: Colors.grey,
              child: Center(
                child: Icon(Icons.music_note, color: Colors.white, size: 100),
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(album.name, overflow: TextOverflow.ellipsis),
                Text("${album.artistName} ꞏ ${album.numTracks} Tracks", overflow: TextOverflow.ellipsis)
              ],
            ),
          )
        ],
      ),
    );
  }
//    return Container(
//      padding: EdgeInsets.all(15.0),
//      child: Row(
//        children: [
//          Expanded(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                Text(song.name),
//                FutureBuilder(
//                  builder: (context, snapshot) {
//                    if(snapshot.connectionState == ConnectionState.none &&
//                        !snapshot.hasData) {
//                      return Text('', style: accentStyle);
//                    }
//                    if(snapshot.data == null) {
//                      return Text('', style: accentStyle);
//                    }
//                    String artist = snapshot.data[0].name;
//                    String album = snapshot.data[1].name;
//                    return Text("$artist ꞏ $album",
//                      style: accentStyle,
//                      overflow: TextOverflow.ellipsis,
//                    );
//                  },
//                  future: Future.wait([
//                    song.artist,
//                    song.album
//                  ])
//                ),
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }
}