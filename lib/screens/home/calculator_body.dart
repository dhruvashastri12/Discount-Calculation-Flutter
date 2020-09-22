import 'package:discount_calc/common/colors.dart';
import 'package:discount_calc/custom/dc_radiobutton.dart';
import 'package:discount_calc/custom/dc_result.dart';
import 'package:discount_calc/custom/dc_textfield.dart';
import 'package:discount_calc/utils/helper.dart';
import 'package:flutter/material.dart';

class CalculatorBody extends StatefulWidget {
  @override
  _CalculatorBodyState createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  final itemPriceController = TextEditingController();
  final itemDiscountController = TextEditingController();

  double payableAmount = 0.0;
  double savingAmount = 0.0;

  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    itemPriceController.addListener(_calculatDiscount);
    itemDiscountController.addListener(_calculatDiscount);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white60,
                        disabledColor: Colors.white60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DCRadioButton(
                          // title: 'Best App development framework',
                          label_1: 'Percentage',
                          label_2: 'Flat Amount',
                          selectedRadio: selectedRadio,
                          onRadioChanged: (int selectionValue) {
                            setState(() {
                              selectedRadio = selectionValue;
                              setSelectedRadio(selectedRadio);
                            });
                          },
                        )
                        // DCRadioButton(
                        //   radioBtnLabel: 'Percentage',
                        //   selectedRadio: 0,
                        //   onRadioChanged: (val) {
                        //     // setSelectedRadio(val);
                        //   },
                        // ),
                        // DCRadioButton(
                        //   radioBtnLabel: 'Flat Amount',
                        //   selectedRadio: 1,
                        //   onRadioChanged: (val) {
                        //     // setSelectedRadio(val);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DCTextField(
                    label: 'Item Price',
                    controller: itemPriceController,
                    maxLength: 10,
                    onClearPressed: () {
                      print('ON CLEAR CLICKED item price');
                      itemPriceController.clear();
                      setState(() {
                        payableAmount = 0.0;
                        savingAmount = 0.0;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  SizedBox(height: 15.0),
                  DCTextField(
                    label: 'Enter Discount DC',
                    controller: itemDiscountController,
                    onClearPressed: () {
                      print('ON CLEAR CLICKED discount');
                      itemDiscountController.clear();
                      setState(() {
                        payableAmount = 0.0;
                        savingAmount = 0.0;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  SizedBox(height: 15.0),
                  DCResultField(
                      displayLabelTxt: 'You save',
                      labelFontSize: 22.0,
                      amntFontSize: 26.0,
                      value: savingAmount),
                  SizedBox(height: 15.0),
                  DCResultField(
                      displayLabelTxt: 'Payable Amount',
                      labelFontSize: 25.0,
                      amntFontSize: 30.0,
                      value: payableAmount)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _calculatDiscount() {
    double itemPrice = double.parse(
        itemPriceController.text != null && itemPriceController.text.isNotEmpty
            ? itemPriceController.text
            : '0');
    double discount = double.parse(itemDiscountController.text != null &&
            itemDiscountController.text.isNotEmpty
        ? itemDiscountController.text
        : '0');

    if (!isValidNumber(itemPrice)) return;
    if (!isValidDiscountNumber(discount)) return;

    if (selectedRadio == 0) {
      double cuttingPrice = (itemPrice * discount) / 100;

      setState(() {
        payableAmount = (itemPrice - cuttingPrice).roundToDouble();
        savingAmount = cuttingPrice.roundToDouble();

        print('Cutting Price: $cuttingPrice');
        print('Saving Amount: $savingAmount');
        print('Percentage Discount: $payableAmount');
      });
    } else {
      setState(() {
        payableAmount = (itemPrice - discount).roundToDouble();
        savingAmount = discount.roundToDouble();

        print('Flat Discount: $payableAmount');
      });
    }
  }

  // // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      _calculatDiscount();
    });
  }

}
