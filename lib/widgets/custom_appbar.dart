import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [Padding(
        padding: const EdgeInsets.only(right: 15,),
        child: IconButton( 
          icon: Icon(Icons.menu_open,size: 40,),
          color: Colors.purpleAccent[200],
          onPressed: ()=>null,),
      )],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
          image: DecorationImage(
              image: AssetImage('images/24426.jpg'), fit: BoxFit.cover),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200);
}
