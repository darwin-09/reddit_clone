import 'package:graphql/client.dart';

final _httpLink =
    HttpLink('https://rickandmortyapi.com/graphql');

final graphQlClient = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
        query: Policies.safe(
      FetchPolicy.networkOnly,
      ErrorPolicy.none,
      CacheRereadPolicy.mergeOptimistic,
    )));
