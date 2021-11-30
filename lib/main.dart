import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/config/beam_locations.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final routeDelegate = BeamerDelegate(
    locationBuilder:
        SimpleLocationGenerator.simpleLocationBuilder,
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routeDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
          delegate: routeDelegate),
      debugShowCheckedModeBanner: false,
    );
  }
}
