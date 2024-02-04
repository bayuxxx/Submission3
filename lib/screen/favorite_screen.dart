import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:submission2/provider/favorites_provider.dart';
import 'package:submission2/screen/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoritesProvider favoritesProvider;

  @override
  void initState() {
    super.initState();
    favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    favoritesProvider.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Restaurants',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<FavoritesProvider>.value(
          value: favoritesProvider,
          child: Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final favorites = favoritesProvider.favorites;
              if (favoritesProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (favorites.isEmpty) {
                return const Center(child: Text('No favorite restaurants.'));
              } else {
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailScreen(restaurantId: favorite.id);
                          }));
                        },
                        child: Row(
                          children: [
                            Hero(
                              tag: favorite.pictureId,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 20, top: 10, right: 10, bottom: 10),
                                width: 100.sp,
                                height: 90.sp,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://restaurant-api.dicoding.dev/images/medium/${favorite.pictureId}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(
                                      favorite.name,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 15.sp,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      favorite.city,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15.sp,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${favorite.rating}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
