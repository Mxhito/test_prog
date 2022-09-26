import 'package:flutter/material.dart';

import '/screens/playlist_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final editingController = TextEditingController(
      text: 'https://open.spotify.com/playlist/3dpOdyAk3AVSSc0CqXQEA6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('MusConv'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set valid Spotify URL to continue',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: editingController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.compare_arrows),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () {
                    if (editingController.text != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlaylistScreen(url: editingController.text),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Oops, empty field'),
                        ),
                      );
                    }
                  },
                  child: const Text('Find playlist/album'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
