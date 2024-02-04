import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:submission2/provider/connectivity_provider.dart';
import 'package:submission2/provider/favorites_provider.dart';
import 'package:submission2/provider/restaurant_detail_provider.dart';
import 'package:submission2/provider/review_provider.dart';
import 'package:submission2/widget/detail_widget/detail_widget.dart';
import 'package:submission2/widget/detail_widget/form_widget.dart';
import 'package:submission2/widget/detail_widget/menu_widget.dart';
import 'package:submission2/widget/disconec.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;

  const DetailScreen({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, _) {
        return DetailScreenView(
          restaurantId: restaurantId,
          restaurantDetailProvider: RestaurantDetailProvider(),
          reviewProvider: ReviewProvider(),
        );
      },
    );
  }
}

class DetailScreenView extends StatelessWidget {
  final String restaurantId;
  final RestaurantDetailProvider restaurantDetailProvider;
  final ReviewProvider reviewProvider;

  const DetailScreenView({
    Key? key,
    required this.restaurantId,
    required this.restaurantDetailProvider,
    required this.reviewProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: restaurantDetailProvider,
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, restaurantDetailProvider, _) {
            if (!connectivityProvider.isConnected) {
              return Disconec(context: context);
            } else if (restaurantDetailProvider.restaurantDetail == null) {
              restaurantDetailProvider.fetchRestaurantDetail(restaurantId);
              return Center(child: Lottie.asset('assets/loading.json'));
            } else {
              final restaurant = restaurantDetailProvider.restaurantDetail!;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      restaurant.name,
                      style: GoogleFonts.poppins(),
                    ),
                    automaticallyImplyLeading: true,
                    floating: true,
                    actions: [
                      IconButton(
                        icon: Icon(
                          favoritesProvider.isFavorite(restaurant.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          final restaurantId = restaurant.id;

                          if (restaurantId.isNotEmpty) {
                            favoritesProvider
                                .toggleFavoriteStatus(restaurantId);
                          }
                        },
                      )
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ImageRestaurant(restaurant: restaurant),
                          const SizedBox(height: 10),
                          LocationWidget(restaurant: restaurant),
                          const SizedBox(height: 5),
                          const Divider(),
                          DescriptionWidget(restaurant: restaurant),
                          const Divider(),
                          AddresWidget(restaurant: restaurant),
                          const SizedBox(height: 5),
                          const Divider(),
                          CategoriesWidget(restaurant: restaurant),
                          const Divider(),
                          FoodsWidget(restaurant: restaurant),
                          const SizedBox(height: 10),
                          DrinksWidget(restaurant: restaurant),
                          const Divider(),
                          const ReviewTitle(),
                          BoxReview(restaurant: restaurant),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AddReview(),
                                const SizedBox(height: 10),
                                FormName(reviewProvider: reviewProvider),
                                const SizedBox(height: 10),
                                FormReview(reviewProvider: reviewProvider),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () async {
                                    await restaurantDetailProvider.submitReview(
                                        context, reviewProvider);
                                  },
                                  child: const ButtomSubmit(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
