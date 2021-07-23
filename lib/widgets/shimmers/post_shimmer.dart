// Project imports:
import 'package:alanis/export.dart';

class PostShimmer extends StatefulWidget {
  @override
  _PostShimmerState createState() => _PostShimmerState();
}

class _PostShimmerState extends State<PostShimmer> {
  double width;

  @override
  Widget build(BuildContext context) {
    width = HelperUtility.fullWidthScreen(context: context);
    return shimmer();
  }

  Widget shimmer() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) =>
            Divider(thickness: 8.0, height: 50, color: Colors.grey.shade200),
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: shimmerBodyColor.withOpacity(0.25),
                          ),
                        ),
                      ),
                    ),
                    title: Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: Container(
                          height: 16,
                          color: shimmerBodyColor.withOpacity(0.25),
                        )),
                    subtitle: Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: Container(
                          height: 10,
                          color: shimmerBodyColor.withOpacity(0.25),
                        ))),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HelperWidget.sizeBox(height: 8.0),
                      Shimmer.fromColors(
                          baseColor: shimmerbaseColor,
                          highlightColor: shimmerhighlightColor,
                          child: Container(
                            height: 14,
                            width: width * 0.7,
                            color: shimmerBodyColor.withOpacity(0.25),
                          )),
                      HelperWidget.sizeBox(height: 8.0),
                      Shimmer.fromColors(
                          baseColor: shimmerbaseColor,
                          highlightColor: shimmerhighlightColor,
                          child: Container(
                            height: 10,
                            width: width,
                            color: shimmerBodyColor.withOpacity(0.25),
                          )),
                      HelperWidget.sizeBox(height: 8.0),
                      Shimmer.fromColors(
                          baseColor: shimmerbaseColor,
                          highlightColor: shimmerhighlightColor,
                          child: Container(
                            height: 10,
                            width: width * 0.6,
                            color: shimmerBodyColor.withOpacity(0.25),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: shimmerbaseColor,
                              highlightColor: shimmerhighlightColor,
                              child: Container(
                                  width: HelperUtility.fullWidthScreen(
                                      context: context),
                                  child: Divider(
                                    thickness: 0.8,
                                    color: Colors.grey[400],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: shimmerbaseColor,
                            highlightColor: shimmerhighlightColor,
                            child: Icon(
                              Icons.star_border,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Shimmer.fromColors(
                              baseColor: shimmerbaseColor,
                              highlightColor: shimmerhighlightColor,
                              child: ImageIcon(
                                AssetImage(
                                  Assets.comments,
                                ),
                                color: Colors.grey[400],
                                size: 17,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
