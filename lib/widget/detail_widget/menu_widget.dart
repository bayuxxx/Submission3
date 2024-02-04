import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:submission2/models/restaurant_detail.dart';

class FoodsWidget extends StatelessWidget {
  const FoodsWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              'Foods',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 11.sp),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 40, // Set the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, foodIndex) {
                final food = restaurant.menus.foods[foodIndex];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      food.name,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 11.sp),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DrinksWidget extends StatelessWidget {
  const DrinksWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              'Drinks',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 11.sp),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 40, // Set the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, drinkIndex) {
                final drink = restaurant.menus.drinks[drinkIndex];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      drink.name,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 11.sp),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
