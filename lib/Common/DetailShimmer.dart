import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nb_utils/nb_utils.dart';

class DetailPageShimmer extends StatelessWidget {
  const DetailPageShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (_, __) => Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 470,
              color: Colors.white,
            ).cornerRadiusWithClipRRect(16),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ).paddingTop(8),
              ],
            ).expand(),
          ],
        ).paddingAll(8),
      ),
    );
  }
}
