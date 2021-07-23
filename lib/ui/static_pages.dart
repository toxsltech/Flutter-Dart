// Project imports:
import 'package:alanis/export.dart';

class StaticPages extends StatefulWidget {
  final String _whichPage;
  final int type;

  StaticPages(this._whichPage, this.type);

  @override
  _StaticPagesState createState() => _StaticPagesState(_whichPage);
}

class _StaticPagesState extends State<StaticPages> {
  String _whichPage;
  String title;
  final GlobalKey webViewKey = GlobalKey();
  bool error = false;
  String url = "";
  double progress = 0;
  StaticPageResponseModel _staticPageResponseModel;
  bool hasData = false;

  _StaticPagesState(this._whichPage);

  @override
  void initState() {
    super.initState();
    _staticPageResponseModel = StaticPageResponseModel();
    _checkPage();
    staticPagesApiCall();
  }

  staticPagesApiCall() {
    APIRepository.staticPagesApiCall(context, widget.type).then((value) {
      if (mounted)
        setState(() {
          _staticPageResponseModel = value;
          hasData = true;
          if (value == null) error = true;
        });
    }).onError((err, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: hasData ? _body() : Center(child: Text("No Data Posted")),
    );
  }

  Widget _appBar() {
    return HelperWidget.appBar(title: widget._whichPage, context: context);
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: error
            ? Center(
                child: Text(
                  "No Data Found",
                  style: HelperUtility.textStyleBold(),
                ),
              )
            : Html(
                data: _staticPageResponseModel?.detail?.description ?? "",
                /*       style: {
                  "p": Style(
                      fontWeight: FontWeight.w400, fontSize: FontSize(14.0)),
                  "body": Style(
                      fontWeight: FontWeight.w400, fontSize: FontSize(14.0))
                },*/
              ),
      ),
    );
  }

  void _checkPage() {
    switch (_whichPage) {
      case Strings.aboutus:
        title = Strings.aboutus;
        break;
      case Strings.help:
        title = Strings.help;
        break;
      case Strings.faq:
        title = Strings.faq;
        break;
      case Strings.privacyPolicy:
        title = Strings.privacyPolicy;
        break;
      case Strings.tc:
        title = Strings.tc;
        break;
    }
  }
}
