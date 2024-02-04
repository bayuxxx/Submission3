import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/search_provider.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      onChanged: (query) {
        Provider.of<SearchProvider>(context, listen: false)
            .updateSearchQuery(query);
        Provider.of<SearchProvider>(context, listen: false).searchRestaurants();
      },
      decoration: InputDecoration(
        focusColor: Colors.grey,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: 'Search',
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: 15, right: 10),
          child: const Icon(
            Icons.search,
            color: Color(0xFF958B7A),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
