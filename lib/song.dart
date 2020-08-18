import 'package:android_media_store/android_media_store.dart';
import 'package:android_media_store/artist.dart';
import 'package:meta/meta.dart';

class Song {
  int id;
  String title;
  int albumId;
  int artistId;
  int track;
  int year;
  Artist _artist;
  Song({
    @required this.id,
    @required this.title,
    @required this.albumId,
    @required this.artistId,
    @required this.track,
    @required this.year
  });

  Future<Artist> get artist async {
    if(_artist != null)
      return _artist;
    _artist = await AndroidMediaStore.getArtistById(artistId);
    return _artist;
  }


}