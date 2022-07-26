import 'package:flutter/material.dart';
import 'package:musicplayer/database/Db_function/playlist_db_folder_function.dart';
import 'package:musicplayer/screen/cataogry/fav_screen.dart';
import 'package:musicplayer/screen/cataogry/add_to_playlist.dart';
import 'package:musicplayer/screen/cataogry/song_list.dart';
import 'package:musicplayer/screen/miniplayer/miniplaylist_screen.dart';
import 'package:musicplayer/screen/search_screen.dart';
import 'package:musicplayer/screen/settings_screen.dart';
import 'package:musicplayer/widgets/song_storage.dart';
class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: const Color.fromARGB(255, 213, 143, 255),
          bottom: const TabBar(
            indicatorColor: Colors.white,

            tabs: [
              
              Tab(
                icon: Icon(
                  Icons.music_note,
                ),
                text: 'Songs',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favourites',
              ),
              Tab(
                icon: Icon(Icons.search),
                text: 'Search',
              ),
              Tab(
                icon: Icon(Icons.queue_music_sharp),
                text: 'PlayList',
              ),
              Tab(
                icon: Icon(Icons.settings_applications_sharp),
                text: 'Settings',
              ),
            ],
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
          ),
        ),
        body:

        
          const TabBarView(children: [
          

          
          SongListScreen(),
          FavListScreen(),
          SearchScreen(),
          AddToPlaylist(),
          SettingsScreen(),
        

        ]

        ),

        



        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: refreshNotifier,       
          // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
          builder: (BuildContext context,bool isTrue,Widget) {
            return Songstorage.player.currentIndex != null?
                const MiniPlayerPage()
               :const SizedBox();
          }
        ) 


        

        //  bottomNavigationBar:Songstorage.player.currentIndex != null ? MiniPlayerPage(): SizedBox()
       
      ),
    );
  }
}
