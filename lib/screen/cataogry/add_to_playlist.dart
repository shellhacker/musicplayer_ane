import 'package:flutter/material.dart';
import 'package:musicplayer/database/Db%20model/playlistmodel.dart';
import 'package:musicplayer/database/Db_function/playlist_db_folder_function.dart';
import 'package:musicplayer/screen/playlist_screens/playlist_song_display_screen.dart';
import 'package:musicplayer/widgets/GlassPhormis.dart';
import 'package:musicplayer/widgets/cmmn_background_color.dart';

class AddToPlaylist extends StatefulWidget {
  const AddToPlaylist({Key? key}) : super(key: key);

  @override
  State<AddToPlaylist> createState() => _AddToPlaylistState();
}

class _AddToPlaylistState extends State<AddToPlaylist> {
  final _formkey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget build(BuildContext context) {
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    playlistNotofier.notifyListeners();
    setState(() {
      getplaylist();
    });
    return CmnBgdClor(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            adplaylistbnt();
          },
          backgroundColor: const Color.fromARGB(255, 74, 8, 118),
          child: const Icon(
            Icons.add,
          ),
        ),
        body: playlistNotofier.value.isEmpty
            ? const Center(
                child: Image(
                image: AssetImage('asset/emptyplaylist.png'),
              ))
            : ValueListenableBuilder(
                valueListenable: playlistNotofier,
                builder: (BuildContext context, List<PlaylistDbmodel> demo,
                    Widget? child) {
                  // playlistNotofier.notifyListeners();
                  // setState(() {

                  // });
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18),
                      itemCount: demo.length,
                      itemBuilder: (BuildContext context, index) {
                        final data = demo[index];
                        return InkWell(onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => PlaylistData(
                                      folderindex: index,
                                      playlist: data,
                                    ))));
                        },
                          child: GlassMorphism(
                            start: 0.1,
                            end: 0.5,
                            child: Card(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Image.asset(
                                          'asset/6-2-folders-png-pic.png')),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Column(
                                            children: [
                                              Text(data.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                      ),
                                      Text("Songs: ${data.songid.length}")
                                            ],
                                          )),
                        
                                      PopupMenuButton(
                                         color: Colors.transparent,
                                           elevation: 0,
                                          itemBuilder: (context) => [
                                              
                                                PopupMenuItem(
                                                  child: ElevatedButton.icon(
                                                    style: ElevatedButton.styleFrom(primary: Colors.black),
                                                    onPressed: () {
                                                      deletplaylistfolder(index);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                      size: 24.0,
                                                    ),
                                                    label: const Text(
                                                        'Delete Playlist'),
                                                  ),
                                                )
                                              ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      
                    ),
                  );
                },
              ),
      ),
    );
  }

  adplaylistbnt() {
    showDialog(
        context: context,
        builder: (index) {
          return AlertDialog(
            title: const Text('Make New List'),
            content: Form(
              key: _formkey,
              child: TextFormField(
                controller: _namecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Playlist Name Is Empty';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formkey.currentState!.validate()) {}
                      onaddplaylist();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 30, 31, 70),
                  ),
                  child: const Text('Create'))
            ],
          );
        });
  }

  Future<void> onaddplaylist() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _name = _namecontroller.text.trim();
    if (_name.isNotEmpty) {
      // ignore: no_leading_underscores_for_local_identifiers
      final _playlist = PlaylistDbmodel(name: _name, songid: []);
      addplaylist(_playlist);
      getplaylist();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 247, 210, 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(8),
          content: Text('Playlist Added Successfully..')));
      Navigator.of(context).pop();
      _namecontroller.clear();
    }
  }

  deletplaylistfolder(index) {
    showDialog(
        context: context,
        builder: (i) {
          return AlertDialog(
            title: const Text('Are you Sure ?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 30, 31, 70),
                    ),
                    child: const Text('NO'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deletplaylist(index);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Color.fromARGB(255, 247, 210, 2),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Playlist Removed Successfully..')));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 30, 31, 70),
                    ),
                    child: const Text('YES'),
                  ),
                ],
              )
            ],
          );
        });
  }
}
