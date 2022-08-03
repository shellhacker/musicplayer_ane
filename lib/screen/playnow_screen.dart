import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/screen/cataogry/song_list.dart';
import 'package:musicplayer/widgets/cmmn_background_color.dart';
import 'package:musicplayer/widgets/cmn_design_widget.dart';
import 'package:musicplayer/widgets/favoritebutton.dart';
import 'package:musicplayer/widgets/song_storage.dart';
import 'package:on_audio_query/on_audio_query.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class PlayNowScreen extends StatefulWidget {
  const PlayNowScreen({
    Key? key,
    required this.songModel,
  }) : super(key: key);
  final List<SongModel> songModel;

  @override
  State<PlayNowScreen> createState() => _PlayNowScreenState();
}

class _PlayNowScreenState extends State<PlayNowScreen> {
  int currentIndex = 0;

  bool _isplaying = false;
  // ignore: prefer_final_fields, unused_field

  void initState() {
    Songstorage.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
        Songstorage.currentIndexx = index;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CmnBgdClor(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        NewBox(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Playing Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: QueryArtworkWidget(
                          id: widget.songModel[currentIndex].id,
                          type: ArtworkType.AUDIO,
                          artworkRepeat: ImageRepeat.noRepeat,
                          nullArtworkWidget: Container(
                              width: 250,
                              height: 250,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              child: const Image(
                                image: AssetImage(
                                    'asset/kevin-mccutcheon-TcSckNRL9J8-unsplash (2).jpg'),
                                fit: BoxFit.fill,
                              ))),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 45,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.songModel[currentIndex].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                widget.songModel[currentIndex].artist
                                            .toString() ==
                                        "<unknown>"
                                    ? "<unknown>"
                                    : widget.songModel[currentIndex].artist
                                        .toString(),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: FavoriteBut(
                              song: SongListScreen.allSongs[currentIndex]),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: ()  {
                             showSliderDialog(context:context,
                             title:"Adjust volume",
                             divisions:10,
                             min: 0.0,
                             max: 1.0,
                             value:Songstorage.player.volume,
                             stream: Songstorage.player.volumeStream,
                             onChanged:Songstorage.player.setVolume);
                              
                            },
                            icon: const Icon(Icons.volume_down_alt)),
                        const SizedBox(
                          width: 150,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.transparent,
                              onPrimary: Colors.black),
                          onPressed: () {
                            Songstorage.player.loopMode == LoopMode.one
                                ? Songstorage.player.setLoopMode(LoopMode.all)
                                : Songstorage.player.setLoopMode(LoopMode.one);
                          },
                          child: StreamBuilder<LoopMode>(
                            stream: Songstorage.player.loopModeStream,
                            builder: (context, snapshot) {
                              final loopMode = snapshot.data;
                              if (LoopMode.one == loopMode) {
                                return const Icon(
                                  Icons.repeat_one,
                                  color: Color.fromARGB(255, 244, 244, 54),
                                );
                              } else {
                                return const Icon(
                                  Icons.repeat,
                                  color: Colors.white,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder<DurationState>(
                        stream: _durationStateStream,
                        builder: (context, snapshot) {
                          final durationState = snapshot.data;
                          final progress =
                              durationState?.position ?? Duration.zero;
                          final total = durationState?.total ?? Duration.zero;
                          return ProgressBar(
                              progress: progress,
                              total: total,
                              barHeight: 3.0,
                              thumbRadius: 5,
                              progressBarColor: Colors.white,
                              thumbColor: Colors.white,
                              baseBarColor: Colors.grey,
                              bufferedBarColor: Colors.grey,
                              buffered: const Duration(milliseconds: 2000),
                              onSeek: (duration) {
                                Songstorage.player.seek(duration);
                              });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (Songstorage.player.hasPrevious) {
                                    Songstorage.player.seekToPrevious();
                                    Songstorage.player.play();
                                  } else {
                                    Songstorage.player.play();
                                  }
                                });
                              },
                              icon: const Icon(Icons.skip_previous)),
                        ),
                        CircleAvatar(
                          radius: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                onPrimary: Colors.transparent,
                                primary: Colors.transparent),
                            onPressed: () async {
                              if (Songstorage.player.playing) {
                                await Songstorage.player.pause();
                                setState(() {});
                              } else {
                                await Songstorage.player.play();
                                setState(() {});
                              }
                            },
                            child: StreamBuilder<bool>(
                              stream: Songstorage.player.playingStream,
                              builder: (context, snapshot) {
                                bool? playingStage = snapshot.data;
                                if (playingStage != null && playingStage) {
                                  return const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (Songstorage.player.hasNext) {
                                    Songstorage.player.seekToNext();
                                    Songstorage.player.play();
                                  } else {
                                    Songstorage.player.play();
                                  }
                                });
                              },
                              icon: const Icon(Icons.skip_next_sharp)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 100.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0)),
                Slider(
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? value,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Songstorage.player.seek(duration);
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          Songstorage.player.positionStream,
          Songstorage.player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}