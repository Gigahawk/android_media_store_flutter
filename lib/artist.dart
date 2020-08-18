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
}
