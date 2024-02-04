import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:submission2/provider/connectivity_provider.dart';
import 'package:submission2/provider/restaurant_provider.dart';
import 'package:submission2/widget/list_widget/appbar_list.dart';
import 'package:submission2/widget/disconec.dart';
import 'package:submission2/widget/list_widget/recommendation.dart';
import 'package:submission2/widget/list_widget/list_widget.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ConnectivityProvider>(
        create: (context) => ConnectivityProvider(),
        child: Consumer<ConnectivityProvider>(
          builder: (context, connectivityProvider, child) {
            return connectivityProvider.isConnected
                ? _buildConnectedScreen(context)
                : Disconec(context: context);
          },
        ),
      ),
    );
  }

  Widget _buildConnectedScreen(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => RestaurantProvider(),
      builder: (context, _) {
        final restaurantProvider = Provider.of<RestaurantProvider>(context);

        restaurantProvider.fetchRestaurants();
        return Consumer<RestaurantProvider>(
          builder: (context, restaurantProvider, child) {
            if (restaurantProvider.isConnected) {
              if (restaurantProvider.restaurants.isEmpty) {
                return Center(
                  child: Lottie.asset('assets/loading.json'),
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    const AppbarList(),
                    const Recommendation(),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final restaurant =
                              restaurantProvider.restaurants[index];
                          return ListWidget(restaurant: restaurant);
                        },
                        childCount: restaurantProvider.restaurants.length,
                      ),
                    ),
                  ],
                );
              }
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          },
        );
      },
    );
  }
}
