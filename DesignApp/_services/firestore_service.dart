import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_by_me/models/font_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference collectionReference =
      Firestore.instance.collection("savedFonts");

  getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Stream<List<FontConfig>> getFontConfigStream(String uid) {
    //make api firebase call to with where
    //With snapshots you will get a stream
    //Getdocuments is a future
    var stream =
        collectionReference.where('userId', isEqualTo: uid).snapshots();

    // return stream.map((qShot) =>
    //     qShot.documents.map((doc) => FontConfig.fromJson(doc.data)).toList());

    return stream.map<List<FontConfig>>((snapshot) {
      return FontConfig.parseList(snapshot);
    });
  }

  Stream<List<FontConfig>> getLastSavedFont(String uid) {
    var stream = collectionReference
        .where('userId', isEqualTo: uid)
        .orderBy('date', descending: true)
        .limit(1)
        .snapshots();

    return stream.map<List<FontConfig>>((snapshot) {
      return FontConfig.parseList(snapshot);
    });
  }
}

//it has to be a stream from firebase and has to be converted to list config

//THe controller has to give the stream to the UI

//And in the UI we need to listen to the stream
