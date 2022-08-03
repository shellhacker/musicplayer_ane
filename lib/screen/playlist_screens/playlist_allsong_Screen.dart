// ignore: file_names
// ignore: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/database/Db%20model/playlistmodel.dart';
import 'package:musicplayer/database/Db_function/favdb_function.dart';
import 'package:musicplayer/widgets/cmmn_background_color.dart';
// ignore: unused_import
import 'package:musicplayer/widgets/song_storage.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlaylistAllSongsScreen extends StatefulWidget {
  static List<SongModel> allSongs = [];
  const PlaylistAllSongsScreen({Key? key,required this.playlist}) : super(key: key);
  final PlaylistDbmodel playlist;

  @override
  State<PlaylistAllSongsScreen> createState() => _PlaylistAllSongsScreenState();
}

class _PlaylistAllSongsScreenState extends State<PlaylistAllSongsScreen> {
//  double playerMinHeight=70;


  final _audioQuery = OnAudioQuery();
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

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    FavoriteDB.favoriteSongs.notifyListeners();

    return CmnBgdClor(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(widget.playlist.name),
          ),
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

                    PlaylistAllSongsScreen.allSongs = item.data!;
                    if (!FavoriteDB.isInitialized) {
                      FavoriteDB.initialise(item.data!);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          itemCount: item.data!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                height: 5,
                                thickness: 2,
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
                              },
                              title: Text(
                                item.data![index].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text('artist name'),
                              trailing:  IconButton(
                                
                                icon:!widget.playlist.isValueIn(item.data![index].id)? const Icon(Icons.add_circle_outline,) :const Icon(Icons.close_rounded) ,
                                color: !widget.playlist.isValueIn(item.data![index].id)? Colors.white:Colors.red,
                              onPressed: (){
                                setState(() {
                                   playlistCheck(item.data![index]);
                                
                                  
                                });
                               

                              },)
                              ,
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


  void playlistCheck(SongModel data){
if(!widget.playlist.isValueIn(data.id)){
widget.playlist.add(data.id);
const snackbar=SnackBar(backgroundColor: Color.fromARGB(255, 247, 210, 2),
behavior: SnackBarBehavior.floating,
margin: EdgeInsets.all(8),content: Text('Added to Playlist',textAlign: TextAlign.center,
style: TextStyle(color: Colors.white),),
);
ScaffoldMessenger.of(context).showSnackBar(snackbar);

 
}else{
  widget.playlist.deleteData(data.id);
  const snackbar=SnackBar(backgroundColor: Color.fromARGB(255, 247, 210, 2),
behavior: SnackBarBehavior.floating,
margin: EdgeInsets.all(8),content: Text('Song Removed From Playlist',textAlign: TextAlign.center,
style: TextStyle(color: Colors.white,),),
);
ScaffoldMessenger.of(context).showSnackBar(snackbar);

}
}


}
