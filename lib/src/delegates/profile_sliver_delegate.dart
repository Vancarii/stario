import 'package:flutter/material.dart';

class ProfileSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight * 3;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
