import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reddit_clone/models/character.dart';

class CharacterListItem extends HookWidget {
  final Character character;

  const CharacterListItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 25, vertical: 10),
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(character.image ?? '',
                  width: 150.0),
            ),
            const SizedBox(width: 25),
            Text(
              character.name ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
