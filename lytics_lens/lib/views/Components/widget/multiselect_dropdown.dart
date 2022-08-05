// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow(
      {Key? key,
      required this.onChange,
      required this.selected,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: CommonColor.filterColor),
          child: Checkbox(
              visualDensity: VisualDensity(horizontal: -3.5, vertical: -2.5),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: BorderSide(width: 1.0, color: CommonColor.filterColor),
              activeColor: CommonColor.greenColor,
              focusColor: CommonColor.filterColor,
              hoverColor: CommonColor.filterColor,
              value: selected,
              onChanged: (x) {
                onChange(x!);
                _theState.notify();
              }),
        ),
        Flexible(
          child: Text(
            text,
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 13,
              color: CommonColor.filterColor,
              fontWeight: FontWeight.w300,
              fontFamily: 'Roboto',
            ),
          ),
        )
      ],
    );
  }
}

class DropDownMultiSelect extends StatefulWidget {
  final List<String> options;
  final RxList<dynamic> filterlist;
  final List<String> selectedValues;
  final Function(List<String>) onChanged;
  final bool isDense;
  final bool enabled;
  final InputDecoration? decoration;
  final String? whenEmpty;
  final Widget Function(List<String> selectedValues)? childBuilder;
  final Widget Function(String option)? menuItembuilder;
  final String Function(String? selectedOptions)? validator;
  final bool readOnly;

  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.whenEmpty,
    required this.filterlist,
    this.childBuilder,
    this.menuItembuilder,
    this.isDense = false,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
}

class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 30,
        child: Stack(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
                child: Text(
                  widget.selectedValues.length > 0
                      ? widget.selectedValues.reduce((a, b) => a + ' , ' + b)
                      : widget.whenEmpty ?? '',
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontSize: 13,
                    color: CommonColor.filterColor,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButtonFormField<String>(
                dropdownColor: CommonColor.bottomSheetBackgroundColour,
                icon: Icon(Icons.keyboard_arrow_down, color: Color(0xffabb4bd)),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Roboto',
                ),
                validator: widget.validator != null ? widget.validator : null,
                decoration: widget.decoration != null
                    ? widget.decoration
                    : InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CommonColor.filterColor, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                            borderSide: BorderSide(width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                          borderSide: BorderSide(
                              color: CommonColor.filterColor, width: 1.0),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                      ),
                isDense: true,
                onChanged: widget.enabled ? (x) {} : null,
                value: widget.selectedValues.length > 0
                    ? widget.selectedValues[0]
                    : null,
                selectedItemBuilder: (context) {
                  return widget.options
                      .map((e) => DropdownMenuItem(
                            child: Container(),
                          ))
                      .toList();
                },
                items: widget.options
                    .map((x) => DropdownMenuItem(
                          child: _theState.rebuilder(() {
                            return widget.menuItembuilder != null
                                ? widget.menuItembuilder!(x)
                                : _SelectRow(
                                    selected: widget.selectedValues.contains(x),
                                    text: x,
                                    onChange: (isSelected) {
                                      if (isSelected) {
                                        var ns = widget.selectedValues;
                                        ns.add(x);
                                        widget.filterlist.add(x);
                                        widget.onChanged(ns);
                                      } else {
                                        var ns = widget.selectedValues;
                                        ns.remove(x);
                                        widget.filterlist.remove(x);
                                        widget.onChanged(ns);
                                      }
                                    },
                                  );
                          }),
                          value: x,
                          onTap: !widget.readOnly
                              ? () {
                                  if (widget.selectedValues.contains(x)) {
                                    var ns = widget.selectedValues;
                                    ns.remove(x);
                                    widget.filterlist.remove(x);
                                    widget.onChanged(ns);
                                  } else {
                                    var ns = widget.selectedValues;
                                    ns.add(x);
                                    widget.filterlist.add(x);
                                    widget.onChanged(ns);
                                  }
                                }
                              : null,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
