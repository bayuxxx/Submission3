import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:submission2/models/restaurant.dart';
import 'package:submission2/screen/detail_screen.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({
    super.key,
    required this.searchResults,
  });

  final List<Restaurant> searchResults;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final restaurant = searchResults[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  restaurantId: restaurant.id,
                ),
              ),
            );
          },
          child: Row(
            children: [
              Hero(
                tag: restaurant.pictureId,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, top: 10, right: 10, bottom: 10),
                  width: 100.sp,
                  height: 90.sp,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
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
                        restaurant.name,
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
                        restaurant.city,
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
                        "${restaurant.rating}",
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
        );
      },
    );
  }
}
