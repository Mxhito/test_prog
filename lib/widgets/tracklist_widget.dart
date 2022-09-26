import 'package:flutter/material.dart';

import '/model/tracklist_model.dart';
import '/network/playlist_service.dart';

class TrackListOfPlayList extends StatelessWidget {
  TrackListOfPlayList({
    Key? key,
    required this.playListName,
    required this.url,
  }) : super(key: key);

  final String url;
  final String playListName;
  final _myParser = MyParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myParser.parseTracklistByPlaylist(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          final tracklistData = snapshot.data as TracklistData;
          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: tracklistData.tracklistNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text(
                  tracklistData.tracklistNames[index],
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(tracklistData.tracklistArtists[index]),
                trailing: Text(tracklistData.duration[index]),
              );
            },
          );
        }
      },
    );
  }
}
