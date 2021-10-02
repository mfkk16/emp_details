import 'package:emp_details/util/color_constants.dart';
import 'package:emp_details/util/font_constants.dart';
import 'package:emp_details/util/sizes.dart';
import 'package:emp_details/util/util_functions.dart';
import 'package:emp_details/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';
import 'view.dart';

class EmployeeDetailsPage extends StatefulWidget {
  final data;

  EmployeeDetailsPage(this.data);

  @override
  _EmployeeDetailsPageState createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> implements EmployeeDetailsView {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final EmployeeDetailsPresenter _presenter = BasicEmployeeDetailsPresenter();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter.onViewAttached(this);
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorConstants.primaryBlack),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: bodyPadding),
      child: Column(
        children: [
          Row(
            children: [
              ImageContainer(imageURL: widget.data["profile_image"] ?? "", radius: 100, width: 80, height: 80),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data["name"] ?? "", style: FontConstants.black18B),
                    SizedBox(height: 5),
                    Text("(${widget.data["username"]})" ?? "", style: FontConstants.shaded14),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          _row(Icons.phone_android_sharp, widget.data["phone"] ?? "", "call"),
          SizedBox(height: 5),
          _row(Icons.email_outlined, widget.data["email"] ?? "", "mail"),
          SizedBox(height: 5),
          _row(Icons.web, widget.data["website"] ?? "", "web"),
          SizedBox(height: 25),
          _address(),
          SizedBox(height: 25),
          _company(),
        ],
      ),
    );
  }

  Widget _address() {
    final item = widget.data["address"];
    if (item == null) return Container();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Address", style: FontConstants.black16B),
            SizedBox(width: 5),
            Expanded(child: Divider(height: 10, color: ColorConstants.primaryBlack, thickness: 2)),
          ],
        ),
        SizedBox(height: 10),
        Text(item["suite"] ?? "", style: FontConstants.black14),
        SizedBox(height: 3),
        Text(item["street"] ?? "", style: FontConstants.black14),
        SizedBox(height: 3),
        Text(item["city"] ?? "", style: FontConstants.black14),
        SizedBox(height: 3),
        Text(item["zipcode"] ?? "", style: FontConstants.black14),
        SizedBox(height: 3),
        InkWell(
          onTap: () => _presenter.onLocationClick(item["geo"]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_pin, size: 15),
              Expanded(child: Text("Address on Map")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _company() {
    final item = widget.data["company"];
    if (item == null) return Container();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Company", style: FontConstants.black16B),
            SizedBox(width: 5),
            Expanded(child: Divider(height: 10, color: ColorConstants.primaryBlack, thickness: 2)),
          ],
        ),
        SizedBox(height: 10),
        Text(item["name"] ?? "", style: FontConstants.black14),
        SizedBox(height: 3),
        Text(item["catchPhrase"] ?? "", style: FontConstants.black14),
        SizedBox(height: 3),
        Text(item["bs"] ?? "", style: FontConstants.black14),
      ],
    );
  }

  _row(icon, name, type) {
    if (name == "") return Container();
    return InkWell(
      onTap: () => _presenter.onContactClick(type, name),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 10),
          Expanded(child: Text(name, style: FontConstants.black14)),
        ],
      ),
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
}
