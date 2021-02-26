import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_call/meeting/join_meeting.dart';
import 'package:flutter_video_call/meeting/new_meeting.dart';
import 'package:flutter_video_call/models/user.dart';
import 'package:flutter_video_call/utils/firebase.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var selectedCard = 'New Meeting';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            // child: CircleAvatar(
            //   radius: 30.0,
            //   backgroundColor: Colors.red,
            // ),

            child: StreamBuilder(
              stream: usersRef.doc(firebaseAuth.currentUser.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  UserModel user = UserModel.fromJson(snapshot.data.data());
                  return CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(user.photoUrl),
                  );
                } else {
                  return CircleAvatar(
                    radius: 30.0,
                    child: Center(
                      child: Icon(Icons.person),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Container(
                height: 80.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: usersRef
                          .doc(firebaseAuth.currentUser.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          UserModel user =
                              UserModel.fromJson(snapshot.data.data());
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Hi, ${user.username}!',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Hi!',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Welcome to Zoomie. join or create a meeting',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   height: 200,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: <Widget>[],
            //   ),
            // ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoCard('New Meeting', CupertinoIcons.video_camera),
                  SizedBox(
                    width: 3.0,
                  ),
                  _buildInfoCard('Join Meeting', Icons.video_call)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String cardTitle, IconData icon) {
    return InkWell(
      onTap: () {
        selectCard(cardTitle);
        if (cardTitle == 'New Meeting') {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => NewMeeting()));
        } else {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => JoinMeeting()));
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: cardTitle == selectedCard
              ? Colors.red[400]
              : Theme.of(context).accentColor,
          border: Border.all(
            color: cardTitle == selectedCard
                ? Colors.transparent
                : Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
            width: 0.75,
          ),
        ),
        height: 200,
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100.0,
              color: Colors.white,
            ),
            Text(
              cardTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cardTitle == selectedCard
                    ? Colors.white
                    : Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
