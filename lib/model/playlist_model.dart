class PlaylistData {
  PlaylistData({
    required this.playlistImg,
    required this.playListName,
    required this.playlistDesc,
  });

  final String playlistImg;
  final String playListName;
  final String playlistDesc;

  @override
  String toString() {
    return 'playlistImg: $playlistImg\n'
        'playListName: $playListName\n'
        'playlistDesc: $playlistDesc\n';
  }
}
