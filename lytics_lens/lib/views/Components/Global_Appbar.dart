import 'package:flutter/material.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String appBarTitle;

GlobalAppbar(
  this.appBarTitle,
);
  @override
  Widget build(BuildContext context) {
    return  AppBar(
      leading: IconButton(
        onPressed: ()=> Scaffold.of(context).openDrawer(), 
        icon: Icon(Icons.sort,size: 35.0,)),
        elevation: 0.0,
        title: Text(appBarTitle),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(27, 29, 40, 1),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}