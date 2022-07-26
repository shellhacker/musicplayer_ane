// ignore: file_names
import 'package:flutter/material.dart';

class Functions extends StatelessWidget {
  const Functions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PopupMenuButton(
          color: Colors.transparent,
          elevation: 0,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.playlist_add_sharp,
                  size: 24.0,
                ),
                label: const Text('Add to Playlist '),
              ),
            ),
            PopupMenuItem(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_add_outlined,
                  size: 24.0,
                ),
                label: const Text('Add to playlist'),
              ),
            )
          ],
        ),
      ],
    );
  }

  static showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Create"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.indigo.shade100,
      title: const Text("Playlist"),
      content: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}