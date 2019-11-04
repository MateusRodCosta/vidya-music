import 'package:flutter/material.dart';
import 'package:vidya_music/src/notifiers/music_player_notifier.dart';
import 'package:vidya_music/src/notifiers/track_list_notifier.dart';
import 'src/screens/main_page.dart';

import 'package:provider/provider.dart';

void main() => runApp(VidyaMusicApp());

class VidyaMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidya Music',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        typography: Typography(
          englishLike: Typography.englishLike2018,
        ),
      ),
      home: MultiProvider(
        providers: [
          ListenableProvider<MusicPlayerNotifier>(
            builder: (context) => MusicPlayerNotifier(),
          ),
          ChangeNotifierProvider<TrackListNotifier>(
            builder: (context) => TrackListNotifier(),
          )
        ],
        child: MainPage(),
      ),
    );
  }
}
