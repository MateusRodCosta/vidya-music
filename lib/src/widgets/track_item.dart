import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vidya_music/src/models/track.dart';
import 'package:vidya_music/src/notifiers/music_player_notifier.dart';

class TrackItem extends StatelessWidget {
  const TrackItem({
    Key key,
    this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerNotifier>(
      builder: (context, notifier, _) {
        return InkWell(
          onTap: () {
            final provider = Provider.of<MusicPlayerNotifier>(context);
            provider.playSelected(track);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Text(
              '${track.creator} - ${track.title}',
            ),
          ),
        );
      },
    );
  }
}
