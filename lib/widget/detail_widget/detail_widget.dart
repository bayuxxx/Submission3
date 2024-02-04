import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:submission2/models/restaurant_detail.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
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
              'Categories',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 11.sp),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 40, // Set the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.categories.length,
              itemBuilder: (context, categoryIndex) {
                final category = restaurant.categories[categoryIndex];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      category.name,
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

class AddresWidget extends StatelessWidget {
  const AddresWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Address: ${restaurant.address}',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 5),
        const Icon(
          Icons.location_on,
          color: Colors.green,
        )
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      restaurant.description,
      trimLines: 4,
      style: GoogleFonts.poppins(color: Colors.black, fontSize: 13.sp),
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: '...Read more',
      trimExpandedText: ' show less',
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.green,
              size: 20.sp,
            ),
            const SizedBox(width: 5),
            Text(
              restaurant.city,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 20.sp,
            ),
            const SizedBox(width: 5),
            Text(
              '${restaurant.rating}',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class BoxReview extends StatelessWidget {
  const BoxReview({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
      height: 150,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: restaurant.customerReviews.length,
        itemBuilder: (context, reviewIndex) {
          final review = restaurant.customerReviews[reviewIndex];
          return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(review.name),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(review.review),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(review.date),
                    const SizedBox(width: 10),
                    const Icon(Icons.date_range_rounded)
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ReviewTitle extends StatelessWidget {
  const ReviewTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Customer Reviews:',
      style: GoogleFonts.poppins(
        color: Colors.black,
      ),
    );
  }
}

class ImageRestaurant extends StatelessWidget {
  const ImageRestaurant({
    super.key,
    required this.restaurant,
  });

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: restaurant.pictureId,
      child: Container(
        width: double.infinity,
        height: 30.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
