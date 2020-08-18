package com.example.android_media_store

import android.app.Activity
import android.content.Context
import android.database.Cursor
import android.net.Uri
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** AndroidMediaStorePlugin */
public class AndroidMediaStorePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "android_media_store")
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.applicationContext
  }

  override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
    activity = binding.activity
  }
  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }
  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }



  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "android_media_store")
      channel.setMethodCallHandler(AndroidMediaStorePlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "getAlbums" -> result.success(getAlbums())
      "getSongs" -> result.success(getSongs())
      "getArtistById" -> result.success(getArtistById(call.argument<Int>("id")))
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun getAlbums() {
  }

  fun getArtistById(id: Int?): Map<String, Any>? {
    if(id == null)
      return null
    val uri: Uri = MediaStore.Audio.Artists.EXTERNAL_CONTENT_URI
    val selection = MediaStore.Audio.Artists._ID + "=?"
    val cursor: Cursor = context.contentResolver.query(
            uri,
            null,
            selection,
            arrayOf(id.toString()),
            null)

    if(cursor != null && cursor.moveToFirst()){
      val nameIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Artists.ARTIST)
      val numAlbumsIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Artists.NUMBER_OF_ALBUMS)
      val numTracksIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Artists.NUMBER_OF_TRACKS)

      val name: String = cursor.getString(nameIdx)
      val numAlbums: Int = cursor.getInt(numAlbumsIdx)
      val numTracks: Int = cursor.getInt(numTracksIdx)

      return mapOf(
              "id" to id,
              "name" to name,
              "numAlbums" to numAlbums,
              "numTracks" to numTracks
      )
    }
    return null
  }

  fun getSongs(): MutableList<Map<String, Any>> {
    val list: MutableList<Map<String, Any>> = mutableListOf()
    val uri: Uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
    val selection = MediaStore.Audio.Media.IS_MUSIC + "!= 0"
    val sortOrder = MediaStore.Audio.Media.TITLE + " ASC"
    val cursor: Cursor = context.contentResolver.query(
            uri,
            null,
            selection,
            null,
            sortOrder
    )
    if(cursor != null && cursor.moveToFirst()) {
      val idIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media._ID)
      val titleIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media.TITLE)
      val albumIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM_ID)
      val artistIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media.ARTIST_ID)
//      val genreIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media.)
      val trackIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media.TRACK)
      val yearIdx: Int = cursor.getColumnIndex(MediaStore.Audio.Media.YEAR)

      do {
        val id: Long = cursor.getLong(idIdx)
        val title: String = cursor.getString(titleIdx)
        val albumId: Long = cursor.getLong(albumIdx)
        val artistId: Long = cursor.getLong(artistIdx)
//        val genreId
        val track: Int = cursor.getInt(trackIdx)
        val year: Int = cursor.getInt(yearIdx)

        list.add(mapOf(
                "id" to id,
                "title" to title,
                "albumId" to albumId,
                "artistId" to artistId,
                "track" to track,
                "year" to year
        ))
      } while(cursor.moveToNext())
    }
    return list
  }
}
