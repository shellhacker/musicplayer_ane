import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/database/Db_function/favdb_function.dart';
import 'package:musicplayer/database/Db_function/playlist_db_folder_function.dart';
import 'package:musicplayer/screen/playnow_screen.dart';
import 'package:musicplayer/widgets/cmmn_background_color.dart';
import 'package:musicplayer/widgets/favoritebutton.dart';
import 'package:musicplayer/widgets/song_storage.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongListScreen extends StatefulWidget {
  static List<SongModel> allSongs = [];
  const SongListScreen({Key? key}) : super(key: key);

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
//  double playerMinHeight=70;

// final ValueNotifier<double> playerExpandProgress = ValueNotifier(min:playerMinHeight);

  static final _audioQuery = OnAudioQuery();
  static final _audioPlayer = AudioPlayer();

  playsong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log('Song Parsing is Error');
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    requestPermission();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void requestPermission() async{
  await Permission.storage.request();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    //FavoriteDB.favoriteSongs.notifyListeners();

    return CmnBgdClor(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<SongModel>>(
                  future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true),
                  builder: (context, item) {
                    if (item.data == null) {
                      return const Center(
                        child: Text(''),
                      );
                    }
                    if (item.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        'No Songs Found',
                        style: TextStyle(fontSize: 20),
                      ));
                    }

                    SongListScreen.allSongs = item.data!;
                    if (!FavoriteDB.isInitialized) {
                      FavoriteDB.initialise(item.data!);
                    }
                    Songstorage.songCopy=item.data!;
                   // Songstorage.playingSongs= item.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          itemCount: item.data!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                height: 15,
                                thickness: 10,
                                
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: ClipRRect(
                                child: QueryArtworkWidget(
                                    id: item.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget:
                                        const Icon(Icons.music_note)),
                              ),
                              onTap: () {
                                Songstorage.player.setAudioSource(Songstorage.createSongList(item.data!),initialIndex: index);
                                Songstorage.player.play();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayNowScreen(songModel: item.data!)
                                          
                                          ),
                                );
                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                refreshNotifier.notifyListeners();

                              },
                              title: Text(
                                item.data![index].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                                
                              ),
                              subtitle:  Text(item.data![index].album!,
                               style: const TextStyle(color: Colors.white),),
                              trailing: FavoriteBut( song: SongListScreen.allSongs[index]),
                            );
                          }),
                    );
                  },
                ),
              ),
              
            ],
          )),
    );
  }

 
}
