import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class TextFieldSearch extends StatefulWidget {
  final List? initialList;
  final String label;
  final TextEditingController controller;
  final Function? future;
  final Function? getSelectedValue;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final int minStringLength;

  const TextFieldSearch(
      {Key? key,
      this.initialList,
      required this.label,
      required this.controller,
      this.textStyle,
      this.future,
      this.getSelectedValue,
      this.decoration,
      this.minStringLength = 2})
      : super(key: key);

  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List? filteredList = <dynamic>[];
  bool hasFuture = false;
  bool loading = false;
  final _debouncer = Debouncer(milliseconds: 1000);
  bool? itemsFound;

  void resetList() {
    List tempList = <dynamic>[];
    setState(() {
      // after loop is done, set the filteredList state from the tempList
      this.filteredList = tempList;
      this.loading = false;
    });
    // mark that the overlay widget needs to be rebuilt
    this._overlayEntry.markNeedsBuild();
  }

  void setLoading() {
    if (!this.loading) {
      setState(() {
        this.loading = true;
      });
    }
  }

  void resetState(List tempList) {
    setState(() {
      this.filteredList = tempList;
      this.loading = false;
      itemsFound = tempList.length == 0 && widget.controller.text.isNotEmpty
          ? false
          : true;
    });
    this._overlayEntry.markNeedsBuild();
  }

  void updateGetItems() {
    this._overlayEntry.markNeedsBuild();
    if (widget.controller.text.length > widget.minStringLength) {
      this.setLoading();
      widget.future!().then((value) {
        this.filteredList = value;
        List tempList = <dynamic>[];
        for (int i = 0; i < filteredList!.length; i++) {
          if (widget.getSelectedValue != null) {
            if (this
                .filteredList![i]
                .label
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase())) {
              tempList.add(this.filteredList![i]);
            }
          } else {
            if (this
                .filteredList![i]
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase())) {
              // if there is a match, add to the temp list
              tempList.add(this.filteredList![i]);
            }
          }
        }
        // helper function to set tempList and other state props
        this.resetState(tempList);
      });
    } else {
      // reset the list if we ever have less than 2 characters
      resetList();
    }
  }

  void updateList() {
    this.setLoading();
    // set the filtered list using the initial list
    this.filteredList = widget.initialList;
    // create an empty temp list
    List tempList = <dynamic>[];
    // loop through each item in filtered items
    for (int i = 0; i < filteredList!.length; i++) {
      // lowercase the item and see if the item contains the string of text from the lowercase search
      if (this
          .filteredList![i]
          .toLowerCase()
          .contains(widget.controller.text.toLowerCase())) {
        // if there is a match, add to the temp list
        tempList.add(this.filteredList![i]);
      }
    }
    // helper function to set tempList and other state props
    this.resetState(tempList);
  }

  void initState() {
    super.initState();

    // throw error if we don't have an initial list or a future
    if (widget.initialList == null && widget.future == null) {
      throw ('Error: Missing required initial list or future that returns list');
    }
    if (widget.future != null) {
      setState(() {
        hasFuture = true;
      });
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context)!.insert(this._overlayEntry);
      } else {
        this._overlayEntry.remove();
        if (itemsFound == false || loading == true) {
          resetList();
          widget.controller.clear();
        }
        if (filteredList!.length > 0) {
          bool textMatchesItem = false;
          if (widget.getSelectedValue != null) {
            textMatchesItem = filteredList!
                .any((item) => item.label == widget.controller.text);
          } else {
            textMatchesItem = filteredList!.contains(widget.controller.text);
          }
          if (textMatchesItem == false) widget.controller.clear();
          resetList();
        }
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  ListView _listViewBuilder(context) {
    if (itemsFound == false) {
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // clear the text field controller to reset it
              widget.controller.clear();
              setState(() {
                itemsFound = false;
              });
              // reset the list so it's empty and not visible
              resetList();
              // remove the focus node so we aren't editing the text
              FocusScope.of(context).unfocus();
            },
            child: ListTile(
              title: Text(
                'No matching items.',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                  color: Color(0xffffffff),
                ),
              ),
              trailing: Icon(
                Icons.cancel,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: filteredList!.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (widget.getSelectedValue != null) {
                widget.controller.text = filteredList![i].label;
                widget.getSelectedValue!(filteredList![i]);
              } else {
                widget.controller.text = filteredList![i];
              }
            });
            resetList();
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: 40.0,
            child: widget.getSelectedValue != null
                ? Text(
                    filteredList![i].label,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Color(0xffffffff),
                    ),
                  ).marginOnly(left: 20, top: 10.0)
                : Text(
                    filteredList![i],
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Color(0xffffffff),
                    ),
                  ).marginOnly(left: 20, top: 10.0),
          ),
        );
      },
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Image.asset(
        "assets/images/gif.gif",
        height: 300.0,
        width: 300.0,
      ),
    );
  }

  Widget? _listViewContainer(context) {
    if (itemsFound == true && filteredList!.length > 0 ||
        itemsFound == false && widget.controller.text.length > 0) {
      double _height =
          itemsFound == true && filteredList!.length > 1 ? 110 : 55;
      return Container(
        height: _height,
        color: Color(0xff23242c),
        child: _listViewBuilder(context),
      );
    }
    return null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size overlaySize = renderBox.size;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: overlaySize.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, overlaySize.height),
          child: Material(
            elevation: 0.0,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: screenWidth,
                  maxWidth: screenWidth,
                  minHeight: 0,
                  maxHeight: itemsFound == true ? 110 : 55,
                ),
                child: loading
                    ? _loadingIndicator()
                    : _listViewContainer(context)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: TextField(
        controller: widget.controller,
        focusNode: this._focusNode,
        decoration: widget.decoration != null
            ? widget.decoration
            : InputDecoration(labelText: widget.label),
        style: widget.textStyle,
        onChanged: (String value) {
          _debouncer.run(() {
            setState(() {
              if (hasFuture) {
                updateGetItems();
              } else {
                updateList();
              }
            });
          });
        },
      ),
    );
  }
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;
  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
