import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:music_player/music_player.dart';
import 'package:vidya_music/src/models/track.dart';

enum MusicPlayerStatus {
  isPlaying,
  isPaused,
  isStopped,
}

class MusicPlayerNotifier with ChangeNotifier {
  final _musicPlayer = MusicPlayer();
  MusicPlayerStatus _musicPlayerStatus;
  List<Track> _trackList = [];
  Track _currentTrack;
  Track _nextTrack;

  final Random rng = Random();

  MusicPlayerNotifier() {
    _musicPlayerStatus = MusicPlayerStatus.isStopped;

    _musicPlayer.onCompleted = playNext;
    _musicPlayer.onPlayNext = playNext;
  }

  Track get currentTrack => _currentTrack;
  Track get nextTrack => _nextTrack;
  MusicPlayerStatus get musicPlayerStatus => _musicPlayerStatus;

  set trackList(List<Track> tracks) {
    _trackList = tracks;
  }

  MusicItem generateMusicInfo(Track t) {
    return MusicItem(
      albumName: 'VIP',
      artistName: t.creator,
      duration: Duration(),
      trackName: t.title,
      url: t.location,
    );
  }

  Track _randomTrack() {
    return _trackList[rng.nextInt(_trackList.length)];
  }

  void _play() {
    try {
      _musicPlayer.play(generateMusicInfo(_currentTrack));

      _musicPlayerStatus = MusicPlayerStatus.isPlaying;
    } catch (ex) {
      _musicPlayerStatus = MusicPlayerStatus.isStopped;
    } finally {
      notifyListeners();
    }
  }

  void _setupAndPlay(Track currentTrack, Track nextTrack) {
    _currentTrack = currentTrack;
    _nextTrack = nextTrack;
    _play();
    notifyListeners();
  }

  void playSelected(Track track) {
    _setupAndPlay(track, _randomTrack());
  }

  void playRandom() {
    _setupAndPlay(_randomTrack(), _randomTrack());
  }

  void playNext() {
    _setupAndPlay(_nextTrack, _randomTrack());
  }

  void resume() {
    _musicPlayer.resume();
    _musicPlayerStatus = MusicPlayerStatus.isPlaying;
    notifyListeners();
  }

  void pause() {
    _musicPlayer.pause();
    _musicPlayerStatus = MusicPlayerStatus.isPaused;
    notifyListeners();
  }
}
