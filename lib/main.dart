import 'package:credit_card_app/UI/credit_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(CreditCardApp());
}

class CreditCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Form',
      debugShowCheckedModeBanner: false,
      home: CreditCardFormScreen(),
    );
  }
}
