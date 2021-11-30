import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reddit_clone/api/characters.graphql.dart';

final apiProvider =
    Provider<ApiProvider>((ref) => ApiProvider());

class ApiProvider {
  final characters = CharactersGraphQL();
}
