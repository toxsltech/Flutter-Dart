// Project imports:
import 'package:alanis/export.dart';

class MessageShimmer extends StatefulWidget {
  @override
  _MessageShimmerState createState() => _MessageShimmerState();
}

class _MessageShimmerState extends State<MessageShimmer> {
  double width;

  @override
  Widget build(BuildContext context) {
    width = HelperUtility.fullWidthScreen(context: context);
    return Scaffold(
      body: shimmer(),
    );
  }

  Widget shimmer() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.0, color: Colors.grey[300]),
            ),
          ),
          height: 90,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListTile(
              title: Shimmer.fromColors(
                baseColor: shimmerbaseColor,
                highlightColor: shimmerhighlightColor,
                child: Container(
                  height: 18,
                  color: shimmerBodyColor.withOpacity(0.25),
                ),
              ),
              subtitle: Shimmer.fromColors(
                baseColor: shimmerbaseColor,
                highlightColor: shimmerhighlightColor,
                child: Container(
                  height: 14,
                  color: shimmerBodyColor.withOpacity(0.25),
                ),
              ),
              leading: Shimmer.fromColors(
                baseColor: shimmerbaseColor,
                highlightColor: shimmerhighlightColor,
                child: Container(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: shimmerBodyColor.withOpacity(0.25),
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
