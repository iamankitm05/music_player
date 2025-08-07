import 'package:flutter/material.dart';

class MusicalNote extends StatelessWidget {
  const MusicalNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.music_note),
    );
  }
}
