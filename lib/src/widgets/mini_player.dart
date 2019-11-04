import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidya_music/src/notifiers/music_player_notifier.dart';

class MiniPlayer extends StatelessWidget {
  final Random rng = Random();

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerNotifier>(
      builder: (context, playerNotifier, _) {
        return Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      playerNotifier.currentTrack?.title ?? 'Song Title',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      playerNotifier.currentTrack?.creator ?? 'Song Creator',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: playerNotifier.musicPlayerStatus !=
                        MusicPlayerStatus.isPlaying
                    ? Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                onPressed: () {
                  if (playerNotifier.musicPlayerStatus !=
                      MusicPlayerStatus.isPlaying) {
                    if (playerNotifier.currentTrack != null) {
                      playerNotifier.resume();
                    } else {
                      playerNotifier.playRandom();
                    }
                  } else {
                    playerNotifier.pause();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (playerNotifier.nextTrack != null) {
                    playerNotifier.playNext();
                  } else {
                    playerNotifier.playRandom();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
