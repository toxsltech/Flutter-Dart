// Project imports:
import 'package:alanis/export.dart';

class ProfProfileShimmer extends StatefulWidget {
  @override
  _ProfProfileShimmerState createState() => _ProfProfileShimmerState();
}

class _ProfProfileShimmerState extends State<ProfProfileShimmer> {
  double width;

  @override
  Widget build(BuildContext context) {
    width = HelperUtility.fullWidthScreen(context: context);
    return shimmer();
  }

  Widget shimmer() {
    {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 130),
            height: 275,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                      baseColor: shimmerbaseColor,
                      highlightColor: shimmerhighlightColor,
                      child: Container(
                        height: 18,
                        color: shimmerBodyColor.withOpacity(0.25),
                      )),
                  Shimmer.fromColors(
                      baseColor: shimmerbaseColor,
                      highlightColor: shimmerhighlightColor,
                      child: Container(
                        height: 12,
                        margin: EdgeInsets.only(bottom: 4),
                        color: shimmerBodyColor.withOpacity(0.25),
                      )),
                  Shimmer.fromColors(
                      baseColor: shimmerbaseColor,
                      highlightColor: shimmerhighlightColor,
                      child: Container(
                        height: 12,
                        margin: EdgeInsets.only(bottom: 4),
                        color: shimmerBodyColor.withOpacity(0.25),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                shimmerBodyColor.withOpacity(0.25)),
                          ),
                          onPressed: () {},
                          child: Text(
                            Strings.following,
                            style: HelperUtility.textStyle(
                                fontsize: 14,
                                color: shimmerBodyColor.withOpacity(0.25)),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Shimmer.fromColors(
                        baseColor: shimmerbaseColor,
                        highlightColor: shimmerhighlightColor,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                shimmerBodyColor.withOpacity(0.25)),
                          ),
                          onPressed: () {},
                          child: Text(
                            Strings.messages,
                            style: HelperUtility.textStyle(
                                fontsize: 14,
                                color: shimmerBodyColor.withOpacity(0.25)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: shimmerbaseColor,
            highlightColor: shimmerhighlightColor,
            child: Container(
              height: 170.00,
              color: shimmerBodyColor.withOpacity(0.25),
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: shimmerBodyColor.withOpacity(0.5),
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
          ),
        ],
      );
    }
  }
}
