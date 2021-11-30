import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/widgets/navbar.dart';
import 'package:reddit_clone/providers/characters_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/modules/character/components/character_list_item.dart';

class CharacterPage extends HookWidget {
  const CharacterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(false);
    final _charactersProvider =
        useProvider(charactersProvider);
    final scrollController = useScrollController();
    int pageNumber = 1;

    _loadInfo() async {
      try {
        await _charactersProvider.getInfo();
      } catch (error) {
        throw Exception(error);
      }
    }

    _loadData() async {
      _isLoading.value = true;
      try {
        // reference to character_provider.dart for this api call
        await _charactersProvider.getCharacters(pageNumber);
      } catch (error) {
        throw Exception(error);
      }
      _isLoading.value = false;
    }

    useEffect(() {
      _loadData();
      _loadInfo();
    }, []);

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          if (_charactersProvider.characters.length !=
              _charactersProvider.info['count']) {
            pageNumber++;
            _loadData();
          }
        }
      });
    }, [scrollController]);

    return Scaffold(
        appBar: CustomMainAppBar(),
        body: Builder(builder: (BuildContext context) {
          if (!_isLoading.value &&
              _charactersProvider.characters.isEmpty) {
            return const Text('No data');
          }

          return Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 750.0,
              ),
              child: ListView.builder(
                controller: scrollController,
                itemExtent: 150,
                itemCount:
                    _charactersProvider.characters.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  final character =
                      _charactersProvider.characters[index];

                  if (index ==
                      _charactersProvider.info['count'] -
                          1) {
                    return const Center(
                        child: Text("No more characters"));
                  }

                  if (index ==
                      _charactersProvider
                              .characters.length -
                          1) {
                    return const LoadingIndicator();
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: CharacterListItem(
                        character: character,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(8.0),
                        color: Colors.grey[700],
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }));
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
