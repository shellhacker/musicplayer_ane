import 'package:flutter/material.dart';
import 'package:musicplayer/screen/playnow_screen.dart';
import 'package:musicplayer/widgets/song_storage.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LisViewBuildercmn extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const LisViewBuildercmn({Key? key, required this.SongModel}) : super(key: key);

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  final SongModel;
  // static final _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: ClipRRect(
                  child: QueryArtworkWidget(
                      id: SongModel[index].id,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: const Icon(Icons.image_not_supported)),
                ),
                title: Text(SongModel[index].title,
                style: const TextStyle(color: Colors.white)),
                onTap: () {
                Songstorage.player.pause();

                                    Songstorage.player.setAudioSource(
                                        Songstorage.createSongList(SongModel),
                                        initialIndex: index);
                                    Songstorage.player.play();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayNowScreen(
                              songModel: SongModel,
                              // index: index,
                            )),
                  );
                },
              ),
              const Divider(
                thickness: 1,
                height: 1,
              )
            ],
          );
        },
        itemCount: SongModel.length,
        shrinkWrap: true,
      ),
    );
  }
}
