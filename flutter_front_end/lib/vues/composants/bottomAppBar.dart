import 'package:flutter/material.dart';
import '../home.dart';
import '../userLibrary.dart';

class MyBottomAppBar extends StatelessWidget {
  final BuildContext context;
  const MyBottomAppBar({required this.context, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(32, 34, 37, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UserLibrary(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                  transitionDuration: const Duration(milliseconds: 0),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                  transitionDuration: const Duration(milliseconds: 0),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return child;
                  },
                  transitionDuration: const Duration(milliseconds: 0),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
