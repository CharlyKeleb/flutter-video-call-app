import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewMeeting extends StatefulWidget {
  @override
  _NewMeetingState createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  String code = '';

  createCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        title: Text(
          'Create a meeting',
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 200.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Generate a meeting code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 60.0,
            width: 160.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(
                code,
                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18.0),
              ),
            ),
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: ()=> createCode(),
            child: Text(
              'Generate',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
