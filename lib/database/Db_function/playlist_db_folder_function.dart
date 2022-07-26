import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer/database/Db%20model/playlistmodel.dart';

ValueNotifier<List<PlaylistDbmodel>> playlistNotofier = ValueNotifier([]);
ValueNotifier<bool> refreshNotifier = ValueNotifier(true);

Future<void>addplaylist(PlaylistDbmodel value) async {
  final playlistDB =  Hive.box<PlaylistDbmodel>('PlayListDB');
await playlistDB.add(value);
   playlistNotofier.value.add(value);
   getplaylist();

  
 
}

Future<void>getplaylist() async {
  final playlistDB = Hive.box<PlaylistDbmodel>('PlayListDB');
  playlistNotofier.value.clear();
  playlistNotofier.value.addAll(playlistDB.values);
// ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  playlistNotofier.notifyListeners();
}

 Future<void>deletplaylist(index) async {
  final playlistDB =  Hive.box<PlaylistDbmodel>('PlayListDB');
  await playlistDB.deleteAt(index);
  getplaylist();
}

// updatePlaylist(index, value) async {
//   final playlistDB = await Hive.openBox<PlaylistDbmodel>('PlayListDB');
//   await playlistDB.putAt(index, value);
//   getplaylist();
// }





  




  // static initialise(List<PlaylistDbmodel> songs) {
//     for (PlaylistDbmodel. song in songs) {
//       if (isfavor(song)) {
//         favoriteSongs.value.add(song);
//       }
//     }
//     isInitialized = true;
//   }

//   static add(PlaylistDbmodel song) async {
//     musicDb.add(song.id);
//     favoriteSongs.value.add(song);
//     FavoriteDB.favoriteSongs.notifyListeners();
//   }

//   static bool isfavor(SongModel song) {
//     if (musicDb.values.contains(song.id)) {
//       return true;
//     }

//     return false;
  // }
