import 'package:html/parser.dart';
import 'package:http/http.dart';

import '/model/playlist_model.dart';
import '/model/tracklist_model.dart';

class MyParser {
  //* Pasre playlist
  Future parsePlaylist(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var document = parse(response.body);

      //* Playlist
      final playlistImg =
          document.getElementsByTagName('img')[0].attributes['src']!;
      final playListName = document.getElementsByTagName('h1')[0].innerHtml;
      final String playlistDesc =
          document.getElementsByClassName('G_f5DJd2sgHWeto5cwbi').isEmpty
              ? ''
              : document
                  .getElementsByClassName('G_f5DJd2sgHWeto5cwbi')[0]
                  .innerHtml;

      final playlistData = PlaylistData(
        playlistImg: playlistImg,
        playListName: playListName,
        playlistDesc: playlistDesc,
      );

      return playlistData;
    }
  }

  //* Pasre tracklist
  Future parseTracklistByPlaylist(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var document = parse(response.body);

      //* Tracklist's names
      final tracklistNames = document
          .getElementsByClassName('EntityRowV2__Link-sc-ayafop-8 cGmPqp')
          .map((e) => e.innerHtml)
          .toList();

      //* Tracklist's atrists (ft)
      final tracklistArtists = document
          .getElementsByClassName(
              'Type__StyledComponent-sc-1ell6iv-0 Mesto-sc-1e7huob-0 Row__Subtitle-sc-brbqzp-1 eJGiPK gmIWQx')
          .map((e) => e
              .getElementsByTagName('a')
              .map((e) => e.innerHtml)
              .toString()
              .substring(1)
              .replaceAll(')', ''))
          .toList();

      //* Duration of tracks
      final trackUrls = document
          .getElementsByClassName(
              'Type__StyledComponent-sc-1ell6iv-0 Ballad-sc-mm6z7p-0 eQsTDZ')
          .map((e) => e
              .getElementsByTagName('a')
              .map((e) => e.attributes['href'])
              .toString()
              .split('/')
              .last
              .replaceAll(')', ''));

      final trackDurationResponses = trackUrls.map((element) async {
        var durationResponce =
            await get(Uri.parse('https://open.spotify.com/track/$element'));
        return durationResponce;
      }).toList();

      return Future.wait(trackDurationResponses).then((value) {
        final duration = <String>[];
        for (var e in value) {
          if (e.statusCode == 200) {
            final document = parse(e.body);
            final tracksDuration = document
                .getElementsByClassName(
                    'Type__TypeElement-goli3j-0 cPwEdQ T3C0eBxRoJcpqMNCpLT6')
                .map((e) => e.innerHtml)
                .toList();
            duration.addAll([tracksDuration.toList()[2]]);
          }
        }
        return duration;

      }).then((value) {
        final tracklistData = TracklistData(
          tracklistNames: tracklistNames,
          tracklistArtists: tracklistArtists,
          duration: value,
        );

        return tracklistData;
      });
    }
  }
}
