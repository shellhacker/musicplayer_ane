import 'package:hive_flutter/adapters.dart';
part 'playlistmodel.g.dart';

@HiveType(typeId: 1)
class PlaylistDbmodel extends HiveObject {


  @HiveField(0)
  List<int> songid;

  @HiveField(1)
  final String name;

  PlaylistDbmodel({required this.name, required this.songid});

  add(int id) async {
    songid.add(id);
    save();
  }

  deleteData(int id) {
    songid.remove(id);
    save();
  }

  bool isValueIn(int id) {
    return songid.contains(id);
  }
}
