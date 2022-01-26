import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomerShimmer extends StatelessWidget {
  const CustomerShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (_, __) => Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 20,
              color: Colors.white,
            ).cornerRadiusWithClipRRect(12),
          ],
        ).paddingAll(8),
      ),
    );
  }
}
