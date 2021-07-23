// Project imports:
import 'package:alanis/export.dart';

class NetworkShimmer extends StatefulWidget {
  @override
  _NetworkShimmerState createState() => _NetworkShimmerState();
}

class _NetworkShimmerState extends State<NetworkShimmer> {
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
        itemCount: 10,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 10.0, child: Divider(color: Colors.grey));
        },
        itemBuilder: (context, index) => Row(
              children: [
                Shimmer.fromColors(
                  baseColor: shimmerbaseColor,
                  highlightColor: shimmerhighlightColor,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(70.0),
                        child: Container(
                          width: 70,
                          height: 70,
                          color: shimmerBodyColor.withOpacity(0.25),
                        )),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ListTile(
                    isThreeLine: true,
                    dense: true,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    contentPadding: EdgeInsets.only(right: 28),
                    title: Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: Container(
                          height: 15,
                          margin: EdgeInsets.only(bottom: 4),
                          color: shimmerBodyColor.withOpacity(0.25),
                        )),
                    subtitle: Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: Column(
                          children: [
                            Container(
                              height: 13,
                              margin: EdgeInsets.only(bottom: 4),
                              color: shimmerBodyColor.withOpacity(0.25),
                            ),
                            Container(
                              height: 13,
                              margin: EdgeInsets.only(bottom: 4),
                              color: shimmerBodyColor.withOpacity(0.25),
                            ),
                          ],
                        )),
                    trailing: Shimmer.fromColors(
                      baseColor: shimmerbaseColor,
                      highlightColor: shimmerhighlightColor,
                      child: Container(
                        height: 22,
                        width: 70,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        color: shimmerBodyColor.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
