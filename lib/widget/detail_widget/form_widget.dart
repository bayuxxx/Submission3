import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:submission2/provider/review_provider.dart';

class FormReview extends StatelessWidget {
  const FormReview({
    super.key,
    required this.reviewProvider,
  });

  final ReviewProvider reviewProvider;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: reviewProvider.reviewController,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: 'Your Review',
        focusColor: Colors.grey,
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class ButtomSubmit extends StatelessWidget {
  const ButtomSubmit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: 50,
      child: Center(
        child: Text(
          "Submit Review",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12.sp),
        ),
      ),
    );
  }
}

class FormName extends StatelessWidget {
  const FormName({
    super.key,
    required this.reviewProvider,
  });

  final ReviewProvider reviewProvider;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: reviewProvider.nameController,
      decoration: InputDecoration(
        labelText: 'Your Name',
        focusColor: Colors.grey,
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class AddReview extends StatelessWidget {
  const AddReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add a Review:',
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
