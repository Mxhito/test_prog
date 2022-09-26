import 'package:flutter/material.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({
    Key? key,
    required this.albumName,
    required this.albumDesc,
    required this.albumImgUrl,
  }) : super(key: key);

  final String albumName;
  final String albumDesc;
  final String albumImgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue[200],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image.network(
                albumImgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(
                albumName,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              Visibility(
                visible: albumDesc.isNotEmpty,
                child: Text(
                  albumDesc,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
