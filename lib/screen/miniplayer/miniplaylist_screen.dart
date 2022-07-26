import 'package:flutter/material.dart';
import 'package:musicplayer/database/Db_function/playlist_db_folder_function.dart';
import 'package:musicplayer/screen/playnow_screen.dart';
import 'package:musicplayer/widgets/favoritebutton.dart';
import 'package:musicplayer/widgets/song_storage.dart';
import 'package:on_audio_query/on_audio_query.dart';


class MiniPlayerPage extends StatefulWidget {
  const MiniPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniPlayerPage> createState() => _MiniPlayerPageState();
}

class _MiniPlayerPageState extends State<MiniPlayerPage> {
  @override
  void initState() {
    Songstorage.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: const Color.fromARGB(255, 56, 3, 97),
        width: deviceSize.width,
        height: 70,
        child: ListTile(
          onTap: () {
             Songstorage.player.setAudioSource(
                 Songstorage.createSongList(Songstorage.songCopy),
                initialIndex: Songstorage.player.currentIndex);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => PlayNowScreen(songModel: Songstorage.playingSongs)));
          },
          iconColor: Colors.white,
          textColor: Colors.white,
          leading: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child:
               QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(10),
                artworkWidth: 100,
                artworkHeight: 400,
                 id: Songstorage.playingSongs[Songstorage.player.currentIndex!].id,
                type: ArtworkType.AUDIO,
              )
              ),
          title:  SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              // ,
             
                   Songstorage.playingSongs[Songstorage.player.currentIndex!].title,
               style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
          ),
          subtitle: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                "${ Songstorage.playingSongs[Songstorage.player.currentIndex!].artistId}",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
              ),
            ),
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              children: [
                
                ValueListenableBuilder(
                  valueListenable: refreshNotifier,
                  builder: (context,bool isTrue,widget)  {
                    return FavoriteBut(song: Songstorage.playingSongs[Songstorage.currentIndexx]);
                  }
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: const Color.fromARGB(255, 27, 27, 27),
                      onPrimary: Colors.white),
                  onPressed: () async {
                    if (Songstorage.player.playing) {
                      await Songstorage.player.pause();
                      setState(() {});
                    } else {
                      if (Songstorage.player.currentIndex != null) {
                        await Songstorage.player.play();
                      }
                      setState(() {});
                    }
                  },
                  child: StreamBuilder<bool>(
                      stream: Songstorage.player.playingStream,
                      builder: (context, snapshot) {
                        bool? playingState = snapshot.data;
                        if (playingState != null && playingState) {
                          return const Icon(
                            Icons.pause,
                            size: 35,
                          );
                        } else {
                          return const Icon(
                            Icons.play_arrow,
                            size: 35,
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}