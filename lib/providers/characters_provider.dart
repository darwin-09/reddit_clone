import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/api/characters.graphql.dart';
import 'package:reddit_clone/models/character.dart';
import 'package:reddit_clone/providers/api_provider.dart';

final charactersProvider = ChangeNotifierProvider((ref) {
  final charactersGraphQL =
      ref.watch(apiProvider).characters;

  return CharactersNotifier(
      charactersAPI: charactersGraphQL);
});

class CharactersNotifier extends ChangeNotifier {
  final CharactersGraphQL charactersAPI;

  CharactersNotifier({
    required this.charactersAPI,
  });

  List<Character> _characters = [];
  List<Character> get characters => _characters;
  Map<String, dynamic> _info = {};
  Map<String, dynamic> get info => _info;

  Future<List<Character>> getCharacters(
      int pageNumber) async {
    // go to characters.graphql.dart to reference this api call
    final data =
        await charactersAPI.getCharacters(pageNumber);
    _characters = [..._characters, ...data];
    return _characters;
  }

  Future<Map<String, dynamic>> getInfo() async {
    final data = await charactersAPI.getInfo();
    _info = data;
    return _info;
  }
}
