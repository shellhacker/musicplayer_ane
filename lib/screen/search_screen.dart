import 'package:flutter/material.dart';
import 'package:musicplayer/screen/cataogry/song_list.dart';
import 'package:musicplayer/screen/settings_screen.dart';
import 'package:musicplayer/widgets/cmmn_background_color.dart';
import 'package:musicplayer/widgets/list_tile_cmn_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SongModel> tempSongs = SongListScreen.allSongs;

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CmnBgdClor(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Find Your Song',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const SettingsScreen()));
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
              TextFormField(cursorColor: Colors.black,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    icon: Icon(
                      Icons.search,
                    ),
                    label: Text(
                      'Search here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onChanged: searchSong),
              
              Expanded(
                child: tempSongs.isNotEmpty?LisViewBuildercmn(
                  SongModel: tempSongs,
                ): Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    
                    Text('Song Not Founded ',style:  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ), 
              )
            ],
          ),
        ),
      ),
    );
  }

  searchSong(String query) {

    
    final suggestions = SongListScreen.allSongs.where((song) {
      final songTitel = song.title.toLowerCase();
      final input = query.toLowerCase(); 

      return songTitel.contains(input);
    }).toList();
    setState(() {
      tempSongs = suggestions;
    });
  }
}
