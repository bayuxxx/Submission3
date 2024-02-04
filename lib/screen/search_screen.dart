import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:submission2/provider/connectivity_provider.dart';
import 'package:submission2/widget/disconec.dart';
import 'package:submission2/widget/search_widget/search_list_widget.dart';
import '../provider/restaurant_provider.dart';
import '../provider/search_provider.dart';
import '../widget/search_widget/search_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Search Restaurants',
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Consumer3<SearchProvider, ConnectivityProvider, RestaurantProvider>(
          builder: (context, searchProvider, connectivityProvider,
              restaurantProvider, _) {
            final searchResults = searchProvider.searchResults;
            final isConnected = connectivityProvider.isConnected;
            connectivityProvider.checkConnectivity();
            if (!isConnected) {
              return Disconec(context: context);
            }
            return Column(
              children: [
                const SearchTextField(),
                const SizedBox(height: 16.0),
                Expanded(
                  child: searchProvider.isLoading
                      ? Center(
                          child: Lottie.asset('assets/loading.json'),
                        )
                      : searchResults.isEmpty
                          ? Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Lottie.asset('assets/batman.json'),
                                    Text(
                                      'Search any restaurant',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SearchListWidget(searchResults: searchResults),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
