// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:alanis/export.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  LoginDataModel data = LoginDataModel();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateFormat dateFormatIni;

  Future<void> getData() async {
    await PrefManger.getRegisterData().then((value) {
      if (mounted)
        setState(() {
          data = value;
        });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    dateFormatIni = DateFormat("yyyy-MM-dd");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            _textView(
                context: context,
                label: Strings.fullName,
                hint: data.fullName ?? ""),
            _textView(
                context: context, label: Strings.email, hint: data.email ?? ""),
            _textView(
                context: context,
                label: Strings.contactNumber,
                hint: data.contactNo ?? ""),
            data?.dateOfBirth == null
                ? CircularProgressIndicator(
                    color: primaryColor,
                    backgroundColor: Colors.white,
                  )
                : _textView(
                    context: context,
                    label: Strings.dob,
                    hint: dateFormat?.format(
                            DateFormat("yyyy-MM-dd").parse(data.dateOfBirth)) ??
                        ""),
            _textView(
              height: null,
              context: context,
              label: Strings.aboutme,
              hint: data.shortDescription ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget _textView(
      {BuildContext context,
      String label,
      String hint,
      double height = Dimens.height_80}) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      width: HelperUtility.fullWidthScreen(context: context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: HelperUtility.textStyleBold(fontsize: Dimens.font_16),
          ),
          Text(
            hint,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: HelperUtility.textStyle(
                fontsize: Dimens.font_15, color: Colors.grey, height: 1.5),
          ),
        ],
      ),
    );
  }
}
