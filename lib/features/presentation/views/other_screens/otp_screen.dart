import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/views/other_screens/login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/custom_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              "Enter OTP Code",
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
                    'assets/images/confirmed.jpg',
                    height: 250,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [_buildPinCodeFields(context)],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Confirm',
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginView())),
            )
          ]),
        ),
      ),
    );
  }
}

Widget _buildPinCodeFields(BuildContext context) {
  return Container(
    color: Colors.white,
    child: PinCodeTextField(
      length: 6,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        borderWidth: 1,
        disabledColor: Colors.white,
        activeColor: Colors.grey,
        inactiveColor: Colors.grey,
        selectedFillColor: Colors.blue[100],
        selectedColor: Colors.blue,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      // errorAnimationController: errorController,
      // controller: textEditingController,
      onCompleted: (code) {
        // optCode = code;
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },
      appContext: context,
    ),
  );
}
