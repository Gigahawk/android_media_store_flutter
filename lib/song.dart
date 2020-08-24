import 'package:android_media_store/android_media_store.dart';
import 'package:android_media_store/artist.dart';
import 'package:meta/meta.dart';

import 'album.dart';

class Song {
  int id;
  String name;
  int albumId;
  int artistId;
  int track;
  int year;
  Artist _artist;
  Album _album;
  Song({
    @required this.id,
    @required this.name,
    @required this.albumId,
    @required this.artistId,
    @required this.track,
    @required this.year
  });

  Song.fromMap(Map s) {
    id = s['id'];
    name = s['name'];
    albumId = s['albumId'];
    artistId = s['artistId'];
    track = s['track'];
    year = s['year'];
  }

  Future<Artist> get artist async {
    if(_artist != null)
      return _artist;
    _artist = await AndroidMediaStore.getArtistById(artistId);
    return _artist;
  }

  Future<Album> get album async {
    if(_album != null)
      return _album;
    _album = await AndroidMediaStore.getAlbumById(albumId);
    return _album;
  }


}