import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/views/other_screens/otp_screen.dart';
import 'package:news_app/features/presentation/views/other_screens/settings_screen.dart';
import 'package:news_app/features/presentation/views/widgets/custom_button.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController? phoneController = TextEditingController();

  final _auth = FirebaseAuth.instance;
// var verificationId = "".observer;
  var verificationId = "";

  void phoneAuthentication(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+2${phoneController!.text}",
      verificationCompleted: (credentials) async {
        await _auth.signInWithCredential(credentials);
        print("complete");
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
        FirebaseAuth.instance.currentUser!.phoneNumber == phoneController!.text;

        print("sent $verificationId");
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
        print("timeout");
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          //TODO: show errors with flutter toast
          print("this phone number is invalid");
        } else {
          print("try again");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials =
        await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ));
    return credentials.user != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black45,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter Your Phone number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(195)),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    'assets/images/verify.jpg',
                    height: 250,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefix: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '+20',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 32,
                ),
              ),
              // onChanged: ,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Send Code',
              onTap: () async {
                phoneAuthentication(phoneController!.text);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OTPScreen()));
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .set(
                  {'phone': phoneController!.text.trim()},
                  SetOptions(merge: true),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
