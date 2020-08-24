// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';

import 'package:android_media_store/album.dart';
import 'package:android_media_store/artist.dart';
import 'package:android_media_store/song.dart';
import 'package:flutter/services.dart';

class AndroidMediaStore {
  static const MethodChannel _channel =
      const MethodChannel('android_media_store');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  
  static Future get albums async {
    List albumMaps =  await _channel.invokeMethod('getAlbums');
    Iterable<Album> albums = albumMaps.map((a) => Album.fromMap(a));
    return albums;
  }

  static Future<Iterable<Artist>> get artists async {
    List artistMaps =  await _channel.invokeMethod('getArtists');
    Iterable<Artist> artists = artistMaps.map((a) => Artist.fromMap(a));
    return artists;
  }

  static Future<Iterable<Song>> get songs async {
    List songMaps =  await _channel.invokeMethod('getSongs');
    Iterable<Song> songs = songMaps.map((s) => Song.fromMap(s));
    return songs;
  }

  static Future<Artist> getArtistById(int id) async {
    Map am = await _channel.invokeMethod(
        'getArtistById', {'id': id});
    Artist artist = Artist.fromMap(am);
    return artist;
  }

  static Future<Album> getAlbumById(int id) async {
    Map am = await _channel.invokeMethod(
        'getAlbumById', {'id': id});
    Album album = Album.fromMap(am);
    return album;
  }

}

