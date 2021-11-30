import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/modules/blog/screens/blog.dart';
import 'package:reddit_clone/modules/blog/screens/blog_details.dart';
import 'package:reddit_clone/modules/character/screens/character.dart';
import 'package:reddit_clone/modules/home/screens/home.dart';

class RouteLocationGenerator {
  static const String homeRoute = '/';
  static const String characterRoute = '/characters';
  static const String blogRoute = '/blogs';
}

//OPTION A: SIMPLE LOCATION BUILDER

class SimpleLocationGenerator {
  static final simpleLocationBuilder =
      SimpleLocationBuilder(
    routes: {
      '/': (context, state) => BeamPage(
            key: const ValueKey('home'),
            title: 'Home',
            child: const HomePage(),
            type: BeamPageType.noTransition,
          ),
      '/characters': (context, state) => BeamPage(
            key: const ValueKey('characters'),
            title: 'Characters',
            child: const CharacterPage(),
            type: BeamPageType.noTransition,
          ),
      '/blogs': (context, state) => BeamPage(
            key: const ValueKey('blogs'),
            title: 'Blogs',
            child: const BlogPage(),
            type: BeamPageType.noTransition,
          ),
      '/blogs/:blog_id': (context, BeamState state) =>
          BeamPage(
            key: ValueKey(
                'blog-${state.pathParameters['blog_id']}'),
            title: '${state.data['title']}',
            popToNamed: '/blogs',
            child: BlogDetailsPage(
              id: state.pathParameters['blog_id']
                  .toString(),
              title: state.data['title'],
              subtitle: state.data['subtitle'],
              body: state.data['body'],
            ),
            type: BeamPageType.noTransition,
          )
    },
  );
}
