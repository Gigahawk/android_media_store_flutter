import 'package:android_media_store/artist.dart';
import 'package:meta/meta.dart';

import 'android_media_store.dart';

class Album {
  int id;
  String name;
  String artistName;
  int artistId;
  int firstYear;
  int lastYear;
  int numTracks;
  Artist _artist;
  Album({
    @required this.id,
    @required this.name,
    @required this.artistName,
    @required this.artistId,
    @required this.firstYear,
    @required this.lastYear,
    @required this.numTracks,
  });

  Album.fromMap(Map a) {
    id = a['id'];
    name = a['name'];
    artistName = a['artistName'];
    artistId = a['artistId'];
    firstYear = a['firstYear'];
    lastYear = a['lastYear'];
    numTracks = a['numTracks'];
  }

  Future<Artist> get artist async {
    if(_artist != null)
      return _artist;
    _artist = await AndroidMediaStore.getArtistById(artistId);
    return _artist;
  }
}
