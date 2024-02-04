import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: Text(
          "Recommendation restaurant for you",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
