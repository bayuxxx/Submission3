import 'package:flutter/material.dart';
import 'package:submission2/screen/search_screen.dart';

class AppbarList extends StatelessWidget {
  const AppbarList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SearchScreen();
            }));
          },
        ),
      ],
      backgroundColor: Colors.black.withOpacity(0.1),
      title: const Text(
        "Welcome",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
