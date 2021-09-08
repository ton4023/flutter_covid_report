import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage('images/doctor-looking.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Covid-19',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.purple[600],
                    fontSize: 40),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Report',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.purple[400],
                    fontSize: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200);
}
