class TracklistData {
  TracklistData({
    required this.tracklistNames,
    required this.tracklistArtists,
    required this.duration,
  });

  final List<String> tracklistNames;
  final List<String> tracklistArtists;
  final List<String> duration;

  @override
  String toString() {
    return 'tracklistNames $tracklistNames\n'
        'tracklistArtists: $tracklistArtists\n'
        'nameDurationMap: $duration\n';
  }
}
