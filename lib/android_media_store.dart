// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:async';

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
    return await _channel.invokeMethod('getAlbums');
  }

  static Future<Iterable<Song>> get songs async {
    List songMaps =  await _channel.invokeMethod('getSongs');
    Iterable<Song> songs = songMaps.map((s) => Song(
        id: s['id'], title: s['title'], albumId: s['albumId'],
        artistId: s['artistId'], track: s['track'], year: s['year']));
    return songs;
  }

  static Future<Artist> getArtistById(int id) async {
    Map am = await _channel.invokeMethod(
        'getArtistById', {'id': id});
    Artist artist = Artist(
        id: am['id'], name: am['name'],
        numAlbums: am['numAlbums'], numTracks: am['numTracks']);
    return artist;
  }

  static Future get artists async {
    return await _channel.invokeMethod('getArtists');
  }
}

