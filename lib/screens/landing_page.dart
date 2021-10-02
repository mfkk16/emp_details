import 'package:emp_details/config/routing_constants.dart';
import 'package:emp_details/util/color_constants.dart';
import 'package:emp_details/util/font_constants.dart';
import 'package:emp_details/util/sizes.dart';
import 'package:emp_details/util/strings.dart';
import 'package:emp_details/widgets/cached_image.dart';
import 'package:emp_details/widgets/circle_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'landing_presenter.dart';
import 'landing_view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> implements LandingView {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final LandingPresenter _presenter = BasicLandingPresenter();
  bool _isLoading = false;
  final List<dynamic> _listEmp = [];
  final List<dynamic> _listEmpTemp = [];

  @override
  void initState() {
    super.initState();
    _presenter.onViewAttached(this);
    _presenter.onLocalDbLoad();
  }

  @override
  void dispose() {
    _presenter.onViewDetached();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: KeyboardDismisser(
        child: Scaffold(
          appBar: AppBar(
            title: Text(appName),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) => _onPopupSelection(value),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Refresh"),
                      value: "refresh",
                    ),
                  ];
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: _isLoading,
            progressIndicator: CircleProgress(size: 50),
            child: _body(),
          ),
        ),
      ),
    );
  }

  _onPopupSelection(value) {
    if (value == "refresh") _presenter.onDataRequest();
  }

  Widget _search() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(color: ColorConstants.bgLightGrey, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: FontConstants.black16,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        onChanged: (val) {
          String searChVal = val.trim().toLowerCase();

          if (searChVal.isEmpty) {
            _listEmpTemp.clear();
            _listEmpTemp.addAll(_listEmp);
            setState(() {});
          } else {
            _listEmpTemp.clear();
            _listEmp.forEach((element) {
              if (element["name"].toLowerCase().contains(searChVal) || element["email"].toLowerCase().contains(searChVal)) {
                _listEmpTemp.add(element);
              }
            });
            setState(() {});
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search by Name or E-Mail",
          hintStyle: FontConstants.shaded16,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _search(),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(bodyPadding),
            itemCount: _listEmpTemp.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final item = _listEmpTemp[index];
              return InkWell(
                onTap: () => _presenter.onCardClick(item),
                child: Row(
                  children: [
                    ImageContainer(imageURL: item["profile_image"], radius: 100),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item["name"], style: FontConstants.black15B),
                          Text(item["email"] ?? "", style: FontConstants.black14),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void onShowMessage(String msg) {
    _scaffoldMessengerKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void onSetProgress(bool value) {
    _isLoading = value;
    setState(() {});
  }

  @override
  void onDataLoaded(data) {
    _listEmp.clear();
    _listEmp.addAll(data);
    _listEmpTemp.clear();
    _listEmpTemp.addAll(data);
    setState(() {});
  }

  @override
  void onNavigateToEmpDetailsPage(item) {
    Navigator.pushNamed(context, EmployeeDetailsViewRoute, arguments: item);
  }
}
