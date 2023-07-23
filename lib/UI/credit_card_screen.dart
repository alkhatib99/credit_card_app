import 'package:credit_card_app/Controllers/credit_card_Controller.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';

import 'package:get/get.dart';

class CreditCardFormScreen extends StatelessWidget {
  final CreditCardFormController _controller =
      Get.put(CreditCardFormController());
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(50.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [headRow(), optionsRow()],
              ),
              Container(
                height: 50,
                color: const Color.fromARGB(255, 0, 59, 108),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Filll Your Credit Card Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          nameTextField(),
                          const SizedBox(height: 8.0),
                          cardYTextField(),
                          const SizedBox(height: 8.0),
                          expTextField(),
                          const SizedBox(height: 8.0),
                          cvvTextField(),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomCircularDropdownButton<String>(
                              items: [
                                "Card Level",
                                "Classic",
                                "Gold",
                                "infinite",
                                "signature",
                                "Platinum"
                              ], // Replace with your own list of items
                              value: _controller.selectedItem.value,
                              onChanged: _controller.onItemSelect,
                            ),
                          ),
                          const SizedBox(height: 16),
                          outlineButton()
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: backImage,
                      ),
                    ),
                  ],
                ),
              ),
            ])
         
            ),
      ),
    );
  }

  outlineButton() => Padding(
        padding: const EdgeInsets.only(
          left: 100.0,
          right: 100,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          height: 60,
          width: 70,
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
            onPressed: _controller.submitForm,
            child: const Text('Submit',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      );

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
