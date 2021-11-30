import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/config/beam_locations.dart';

class CustomMainAppBar extends PreferredSize {
  final Size _preferredSize;

  CustomMainAppBar({
    Key? key,
    Size? preferredSIze,
  })  : _preferredSize = const Size.fromHeight(75),
        super(
          key: key,
          preferredSize: const Size.fromHeight(75),
          child: Container(),
        );

  @override
  Size get preferredSize => _preferredSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[700],
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            MenuButton(
              text: 'Home',
              routeName: RouteLocationGenerator.homeRoute,
            ),
            MenuButton(
              text: 'Blog',
              routeName: RouteLocationGenerator.blogRoute,
            ),
            MenuButton(
              text: 'Character',
              routeName:
                  RouteLocationGenerator.characterRoute,
            ),
          ],
        ));
  }
}

class MenuButton extends StatelessWidget {
  final String? text;
  final String routeName;

  const MenuButton({
    Key? key,
    this.text,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)!.settings.name;

    return Container(
      height: 75,
      constraints: const BoxConstraints(minWidth: 50),
      child: TextButton(
        child: Text(text!,
            style: const TextStyle(color: Colors.white)),
        onPressed: () {
          if (route != routeName) {
            Beamer.of(context).beamToNamed(
              routeName,
            );
          }
        },
      ),
    );
  }
}
