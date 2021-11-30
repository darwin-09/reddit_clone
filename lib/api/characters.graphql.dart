import 'package:graphql/client.dart';
import 'package:reddit_clone/config/graphql.dart';
import 'package:reddit_clone/models/models.dart';

class CharactersGraphQL {
  /// Schema of the query
  /// Write the variable name and put the schema inside. Wrap r'''<Schema> ''';
  final String _getCharacters = r'''
  query GetCharacters($page: Int){
    characters(page: $page) {
      results {
        id
        name
        image
      }
    }
  }
  ''';

  final String _getInfo = r''' 
  query {
    characters {
      info {
        count
        pages
        next
        prev
      }
    }
  }
  ''';

  // The function that calls the API
  Future<List<Character>> getCharacters(
      int pageNumber) async {
    //write the document
    final options = QueryOptions(
      document: gql(_getCharacters),
      variables: {
        'page': pageNumber,
      },
    );

    //call the api itself
    //import the graphQLCLient
    //call graphQLClient.query() if we want to make GET requests
    //call graphQLClient.mutate() if we want to make POST/DELETE/UPDATE requests
    //pass down QueryOptions inside the mutate() or query();
    final response = await graphQlClient.query(options);
    //check if exception is null or not
    if (!response.hasException) {
      //access the results
      final List<Object?> data =
          response.data!['characters']['results'];
      final values = data.map((character) =>
          Character.fromJson(
              character as Map<String, dynamic>));

      return values.toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Map<String, dynamic>> getInfo() async {
    final options = QueryOptions(
      document: gql(_getInfo),
    );

    final response = await graphQlClient.query(options);
    if (!response.hasException) {
      //access the results
      final Map<String, dynamic> data =
          response.data!['characters']['info'];

      return data;
    } else {
      throw Exception("Failed to load info");
    }
  }
}
