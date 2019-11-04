import 'package:flutter/material.dart';
import 'package:vidya_music/src/notifiers/music_player_notifier.dart';
import 'package:vidya_music/src/notifiers/track_list_notifier.dart';
import 'package:provider/provider.dart';
import 'package:vidya_music/src/widgets/mini_player.dart';
import 'package:vidya_music/src/widgets/track_item.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TrackListNotifier>(context).initialSync());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vidya Music'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Vidya Player',
                applicationVersion: '0.0.1',
                applicationLegalese:
                    '© Mateus Rodrigues Costa, Licensed under AGPLv3+',
              );
            },
          ),
        ],
      ),
      body: new VidyaPlayer(),
    );
  }
}

class VidyaPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TrackListNotifier, MusicPlayerNotifier>(
      builder: (context, tracksNotifier, playerNotifier, _) {
        playerNotifier.trackList = tracksNotifier.trackList;
        return Center(
          child: tracksNotifier.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : tracksNotifier.isSucess
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, i) {
                              return Divider(
                                height: 1,
                              );
                            },
                            itemCount: tracksNotifier.trackList.length,
                            itemBuilder: (context, i) {
                              return TrackItem(
                                track: tracksNotifier.trackList[i],
                              );
                            },
                          ),
                        ),
                        MiniPlayer(),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('We had a problem getting the track list.'),
                          Text('Please press the button below to retry.'),
                          SizedBox(
                            height: 16.0,
                          ),
                          RaisedButton(
                            child: Text('Retry'),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              tracksNotifier.initialSync();
                            },
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
