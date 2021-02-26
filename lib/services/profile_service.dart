import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_video_call/services/service.dart';
import 'package:flutter_video_call/utils/firebase.dart';

import 'package:uuid/uuid.dart';

class PostService extends Service {
  String postId = Uuid().v4();

  uploadProfilePicture(File image, User user) async {
    String link = await uploadImage(profilePic, image);
    var ref = usersRef.doc(user.uid);
    ref.update({
      "photoUrl": link,
    });
  }
}
