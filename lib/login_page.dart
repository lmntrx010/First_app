import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();

    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset("assets/images/login.png", fit: BoxFit.cover),
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Text(
              "WELCOME",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Enter username",
                    labelText: "Username",
                  ),
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    hintText: "Enter Phone Number",
                    labelText: "Phone Number",
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              child: Text("Login"),
              style: TextButton.styleFrom(minimumSize: const Size(150, 40)),
              onPressed: () {
                String phoneNumber = phoneNumberController.text;
                String message = 'Hello, this is a test message!';
                _sendingSMS(phoneNumber, message);
                /*
                Telephony telephony = Telephony.instance;
                telephony.sendSms(
                  to: phoneNumber,
                  message: message,
                );*/

                //print('Sent SMS to $phoneNumber: $message');
              })
        ],
      ),
    );
  }
}

void _sendingSMS(String m1, String m2) async {
  // Replace with your Twilio account SID, auth token, and phone numbers
  const String accountSid = 'ACb12e48d7e601f850f2c024100440d6b9';
  const String authToken = '9b3f03f02223dc8db8a19a68b012982d';
  const String fromNumber = '+13613392520';
  String toNumber = m1; // Replace with the recipient's phone number

  String message = m2; // Replace with your desired message

  const String url =
      'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
    },
    body: {
      'From': fromNumber,
      'To': toNumber,
      'Body': message,
    },
  );

  if (response.statusCode == 201) {
    print('SMS sent successfully');
  } else {
    print('Failed to send SMS: ${response.body}');
  }
}
