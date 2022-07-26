
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/database/Db%20model/playlistmodel.dart';
import 'package:musicplayer/database/Db_function/playlist_db_folder_function.dart';
import 'package:musicplayer/screen/cataogry/song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';







getallPlaylists() async {
  final playlistDb = await Hive.openBox<PlaylistDbmodel>('PlayListDB');
  playlistNotofier.value.clear();
  playlistNotofier.value.addAll(playlistDb.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  playlistNotofier.notifyListeners();
}


List<SongModel>playloop=[];

class Playlistsongcheck {
  static ValueNotifier<List> selectPlaySong = ValueNotifier([]);
  static showSelectSong(index) async {
    final checkSong = playlistNotofier.value[index].songid;
    selectPlaySong.value.clear();
    playloop.clear();
    for (int i = 0; i < checkSong.length; i++) {
      for (int j = 0; j < SongListScreen.allSongs.length; j++) {
        if (SongListScreen.allSongs[j].id == checkSong[i]) {
          selectPlaySong.value.add(j);
          playloop.add(SongListScreen.allSongs[j]);
          break;
        }
      }
    }
  }
}