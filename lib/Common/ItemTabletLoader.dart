import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemmTablet extends StatelessWidget {
  const ItemmTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.1, crossAxisCount: 6),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 12,
      itemBuilder: (_, __) => Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300],
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 6.2,
              height: 120,
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

class Horizonatal extends StatelessWidget {
  const Horizonatal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.1),
          crossAxisCount: 4),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 12,
      itemBuilder: (_, __) => Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300],
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 6.2,
              height: 120,
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
