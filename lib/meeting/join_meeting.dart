import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_call/models/user.dart';
import 'package:flutter_video_call/utils/firebase.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  bool videoMute = true;
  bool audioMute = true;
  TextEditingController roomTEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: ()=>joinMeeting(),
          child: Text('Join Meeting'),
        ),
      ),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace),
        ),
        title: Text('Meeting Setup'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 25.0),
          Center(
            child: Text(
              'Meeting Code',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PinCodeTextField(
              controller: roomTEC,
              backgroundColor: Colors.transparent,
              appContext: context,
              length: 6,
              autoDisposeControllers: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(shape: PinCodeFieldShape.circle),
              animationDuration: Duration(milliseconds: 250),
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: 20.0),
          CheckboxListTile(
            value: videoMute,
            onChanged: (value) {
              setState(() {
                videoMute = value;
              });
            },
            title: Text('Mute Video'),
          ),
          CheckboxListTile(
            value: audioMute,
            onChanged: (value) {
              setState(() {
                audioMute = value;
              });
            },
            title: Text('Mute Audio'),
          )
        ],
      ),
    );
  }

  joinMeeting() async {
    DocumentSnapshot doc = await usersRef.doc(firebaseAuth.currentUser.uid).get();
   var user = UserModel.fromJson(doc.data());
    try {
     FeatureFlag featureflags = FeatureFlag();
     featureflags.welcomePageEnabled = false;
     featureflags.pipEnabled = false;
     featureflags.callIntegrationEnabled = false;
     featureflags.chatEnabled = true;
     

      // if (Platform.isAndroid) {
      //   featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      // } else if (Platform.isIOS) {
      //   featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      // }
       var options = JitsiMeetingOptions()
      ..room = roomTEC.text
      ..userDisplayName = user.username
      ..userAvatarURL = user.photoUrl
      ..userEmail = user.email
      ..videoMuted = videoMute
      ..audioMuted = audioMute
      ..featureFlag = featureflags;

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print('Error: $e');
    }
  }
}
