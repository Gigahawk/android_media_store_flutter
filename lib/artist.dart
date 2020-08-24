import 'package:meta/meta.dart';

class Artist {
  int id;
  String name;
  int numAlbums;
  int numTracks;
  Artist({
    @required this.id,
    @required this.name,
    @required this.numAlbums,
    @required this.numTracks,
  });

  Artist.fromMap(Map a) {
    id = a['id'];
    name = a['name'];
    numAlbums = a['numAlbums'];
    numTracks = a['numTracks'];
  }
}
