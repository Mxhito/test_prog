import 'package:flutter/material.dart';

import '/model/playlist_model.dart';
import '/network/playlist_service.dart';
import '/widgets/tracklist_widget.dart';
import '/widgets/playlist_widget.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({Key? key, required this.url}) : super(key: key);

  final String url;
  final _myParser = MyParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist/Album'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _myParser.parsePlaylist(url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final playlistData = snapshot.data as PlaylistData;
              return ListView(
                primary: true,
                children: [
                  PlaylistWidget(
                    albumDesc: playlistData.playlistDesc,
                    albumImgUrl: playlistData.playlistImg,
                    albumName: playlistData.playListName,
                  ),
                  TrackListOfPlayList(
                    url: url,
                    playListName: playlistData.playListName,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
