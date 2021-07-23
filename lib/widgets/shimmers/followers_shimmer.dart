// Project imports:
import 'package:alanis/export.dart';

class FollowerShimmer extends StatefulWidget {
  @override
  _FollowerShimmerState createState() => _FollowerShimmerState();
}

class _FollowerShimmerState extends State<FollowerShimmer> {
  double width;

  @override
  Widget build(BuildContext context) {
    width = HelperUtility.fullWidthScreen(context: context);
    return Scaffold(
      body: shimmer(),
    );
  }

  Widget shimmer() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 10),
          child: GestureDetector(
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: shimmerbaseColor,
                  highlightColor: shimmerhighlightColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Container(
                      height: 70,
                      width: 70,
                      color: shimmerBodyColor.withOpacity(0.25),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Shimmer.fromColors(
                  baseColor: shimmerbaseColor,
                  highlightColor: shimmerhighlightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: width * .6,
                        color: shimmerBodyColor.withOpacity(0.25),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 13,
                        width: width * .6,
                        color: shimmerBodyColor.withOpacity(0.25),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
