import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemGroupLoaderMobile extends StatelessWidget {
  const ItemGroupLoaderMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.1),
          crossAxisCount: 3),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9,
      itemBuilder: (_, __) => Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300],
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.2,
              height: 80,
              color: Colors.white,
            ).cornerRadiusWithClipRRect(12),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.2,
              height: 20,
              color: Colors.white,
            ).cornerRadiusWithClipRRect(12),
          ],
        ).paddingAll(8),
      ),
    );
  }
}
