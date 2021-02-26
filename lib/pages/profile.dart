import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Still on Development',
          style: TextStyle(fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
