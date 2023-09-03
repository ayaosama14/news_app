import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/info_card.dart';
import 'login_screen.dart';

List<String> categoryList = [
  'business',
  'entertainment',
  'general',
  'science',
  'sports',
  'technology',
  'health',
];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final userId = FirebaseAuth.instance.currentUser!.uid;
var email = FirebaseAuth.instance.currentUser!.email;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              InfoCard(text: email, icon: Icons.email),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('modelValues')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InfoCard(
                            text:
                                '${snapshot.data!.docs[index].id.toString()}: ${snapshot.data!.docs[index]['summary'].toString()}'
                            // '${categoryList[index]}: ${summaryNumber(categoryList[index])}',
                            );
                      },
                    );
                  },
                ),
              ),
              InfoCard(
                text: "Sign Out",
                icon: Icons.logout,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginView();
                  }));
                },
              ),
              // const Spacer(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
