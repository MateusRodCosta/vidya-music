import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vidya_music/src/utils/playlist_xml_utils.dart';
import 'package:vidya_music/src/models/track.dart';

class TrackListNotifier with ChangeNotifier {
  List<Track> _trackList = [];
  bool _isLoading = false;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  bool get isSucess => _isSuccess;

  List<Track> get trackList => _trackList;

  set trackList(List<Track> newTracks) {
    _trackList = newTracks;
    notifyListeners();
  }

  Future<void> initialSync() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await http.read('https://vip.aersia.net/roster.xml');

      _trackList = PlaylistXmlUtils.parseData(result);
      _isSuccess = true;
    } catch (ex) {
      _isSuccess = false;
      print(ex);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
