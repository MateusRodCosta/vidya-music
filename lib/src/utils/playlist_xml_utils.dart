import 'package:xml/xml.dart' as xml;
import '../models/track.dart';

class PlaylistXmlUtils {
  static List<Track> parseData(data) {
    var document = xml.parse(data);
    var playlistTag = document.children.singleWhere(
        (node) => node is xml.XmlElement && node.name.local == 'playlist');
    var trackListTag = playlistTag.children.singleWhere(
        (node) => node is xml.XmlElement && node.name.local == 'trackList');

    List<Track> tracks = [];
    trackListTag.children
        .where((node) => node is xml.XmlElement && node.name.local == 'track')
        .forEach((trackTag) {
      String creator = trackTag.children
          .singleWhere(
              (node) => node is xml.XmlElement && node.name.local == 'creator')
          .text;
      String title = trackTag.children
          .singleWhere(
              (node) => node is xml.XmlElement && node.name.local == 'title')
          .text;
      String location = trackTag.children
          .singleWhere(
              (node) => node is xml.XmlElement && node.name.local == 'location')
          .text;
      Track t = Track(creator: creator, title: title, location: location);

      tracks.add(t);
    });
    return tracks;
  }
}
