import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllSongsTabView extends ConsumerWidget {
  const AllSongsTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    return ListView.builder(
      padding: EdgeInsets.only(top: 10, left: 16, right: 6, bottom: 10),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.music_note),
          ),
          title: Text('Song #${index + 1}'),
          subtitle: Text('Unknown'),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
        );
      },
    );
  }
}
