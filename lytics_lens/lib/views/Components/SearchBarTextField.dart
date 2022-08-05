import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lytics_lens/Constants/common_color.dart';

// import 'package:lytics_lens/Views/Components/NoSearchFoundScreen.dart';
// import 'package:lytics_lens/Views/home_screen.dart';

var searchText;

// ignore: must_be_immutable
class SearchBarTextField extends StatelessWidget {
  // final control;
  // final List <dynamic> textForSearch=[];
  TextEditingController serController = new TextEditingController();
  final void Function(String)? onChanged;
  final String text;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onIconTap;
  final TextEditingController? controller;

  SearchBarTextField(this.serController, this.onChanged, this.text,
      this.onFieldSubmitted, this.onIconTap, this.controller);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return MediaQuery(
      data: mqDataNew,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13.0)),
          color: Color(0xff455177),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 0.0, bottom: 0.0, right: 10.0, left: 10.0),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                style: TextStyle(color: Colors.white, fontSize: 17.0),
                cursorColor: CommonColor.greenColor,
                cursorHeight: 24,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
                inputFormatters: [LengthLimitingTextInputFormatter(64)],
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 45.0),
                  hintText: "Search Alerts",
                  isDense: true,
                  hintStyle: TextStyle(color: Color(0xFFD3D3D3), fontSize: 16),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/search-green.png"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  "$text Results",
                  style: TextStyle(
                      color: Color(0xFFD3D3D3),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4),
                ),
              ),
              GestureDetector(
                onTap: onIconTap,
                child: Icon(
                  Icons.clear,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    
    );
  }

  Widget buildCustomPrefixIcon() {
    return Container(
      width: 0,
      // alignment: Alignment(-1.5, 0),
    );
  }
}
