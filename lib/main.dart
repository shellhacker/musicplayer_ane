import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/database/Db%20model/playlistmodel.dart';
import 'package:musicplayer/database/Db_function/playlist_db_folder_function.dart';
import 'package:musicplayer/screen/splash_screenimage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(PlaylistDbmodelAdapter().typeId)) {
    Hive.registerAdapter(PlaylistDbmodelAdapter());
  }
    await Hive.openBox<int>('favoriteDB');
    await Hive.openBox<PlaylistDbmodel>('PlayListDB');
    getplaylist();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 213, 143, 255),
          secondaryHeaderColor: const Color.fromARGB(255, 30, 4, 47),
          tabBarTheme: const TabBarTheme()),
      home: const SplashScreenImage(),
    );
  }
}

