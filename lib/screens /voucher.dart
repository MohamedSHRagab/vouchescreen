import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:voucher/models/Product.dart';

class Voucher_screen extends StatefulWidget {
  @override
  _Voucher_screenState createState() => _Voucher_screenState();
}

class _Voucher_screenState extends State<Voucher_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHiddenPassword = true;
  String? selectedValue;
  String? selectedValue2;
  List<String> items = [
    'ITEM POS',
    'ALU',
    'UPC',
    'VEND CODE',
    'DESCRIPTION',
    'PRICE',
    'COST',
    'ITEM COST',
    'STORE QUANTITY',
  ];
  List<String> items2 = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  List<String> search_data = [];
  List<String> search2_data = [];
  List<Product> products_items = [];
  List<Product> products_list = [
    Product(
        id: '0',
        itempos: 'itempos',
        alu: '330031',
        upc: '00000330031',
        vendcode: '001',
        description: "panadol extra 100MG",
        price: 100,
        cost: 50,
        itemcost: 25,
        quantity: 1,
        Storequantity: 15),
    Product(
        id: '2',
        itempos: 'itempos2',
        alu: '440041',
        upc: '00000440041',
        vendcode: '001',
        description: "pantazol 40mg",
        price: 95,
        cost: 35,
        itemcost: 28,
        quantity: 1,
        Storequantity: 1),
    Product(
        id: '3',
        itempos: 'itempos3',
        alu: '550041',
        upc: '00000550041',
        vendcode: '002',
        description: "fevadol 200 mg",
        price: 10,
        cost: 3.5,
        itemcost: 3.5,
        quantity: 1,
        Storequantity: 1),
    Product(
        id: '4',
        itempos: 'itempos4',
        alu: '660061',
        upc: '00000660061',
        vendcode: '002',
        description: "solpadeen 50 MG",
        price: 45.5,
        cost: 22.5,
        itemcost: 20,
        quantity: 1,
        Storequantity: 1)
  ];

  TextEditingController search_controller = new TextEditingController();
  TextEditingController search2_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (selectedValue == null) {
      search_data.clear();
      for (int i = 0; i < products_list.length; i++) {
        search_data.add(products_list[i].alu);
        search_data.add(products_list[i].description);
        search_data.add(products_list[i].upc);
        setState(() {});
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Voucher Items ",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(26, 61, 109, 1),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Retail-Tec",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  'Invoice Num : 123',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Color.fromRGBO(26, 61, 109, 1),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Search by',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(26, 61, 109, 1),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(26, 61, 109, 1),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  search_controller.text="";
                                  setState(() {
                                    selectedValue = value as String;
                                    setState(() {
                                      search_data.clear();
                                    });
                                    if (selectedValue == "ITEM POS") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(products_list[i].itempos);
                                      }
                                    } else if (selectedValue == "ALU") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(products_list[i].alu);
                                      }
                                    } else if (selectedValue == "UPC") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(products_list[i].upc);
                                      }
                                    } else if (selectedValue == "VEND CODE") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data
                                            .add(products_list[i].vendcode);
                                      }
                                    } else if (selectedValue == "DESCRIPTION") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data
                                            .add(products_list[i].description);
                                      }
                                    } else if (selectedValue == "PRICE") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(
                                            products_list[i].price.toString());
                                      }
                                    } else if (selectedValue == "COST") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(
                                            products_list[i].cost.toString());
                                      }
                                    } else if (selectedValue == "ITEM COST") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(
                                            products_list[i].itemcost.toString());
                                      }
                                    } else if (selectedValue ==
                                        "STORE QUANTITY") {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(products_list[i]
                                            .Storequantity
                                            .toString());
                                      }
                                    } else {
                                      for (int i = 0;
                                          i < products_list.length;
                                          i++) {
                                        search_data.add(products_list[i].alu);
                                        search_data
                                            .add(products_list[i].description);
                                        search_data.add(products_list[i].upc);
                                        setState(() {});
                                      }
                                    }
                                    setState(() {});
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Color.fromRGBO(26, 61, 109, 1),
                                iconDisabledColor: Colors.grey,
                                buttonHeight: 50,
                                buttonPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Color.fromRGBO(241, 242, 243, 1),
                                ),
                                buttonElevation: 2,
                                itemHeight: 40,
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 200,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color.fromRGBO(241, 242, 243, 1),
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                          ),
                          inputItem(context, 'Search by', search_controller,
                              search_data)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Color.fromRGBO(26, 61, 109, 1),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Calculation Options',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(26, 61, 109, 1),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items2
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(26, 61, 109, 1),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue2,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue2 = value as String;
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Color.fromRGBO(26, 61, 109, 1),
                                iconDisabledColor: Colors.grey,
                                buttonHeight: 50,
                                buttonPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Color.fromRGBO(241, 242, 243, 1),
                                ),
                                buttonElevation: 2,
                                itemHeight: 40,
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownWidth: 200,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color.fromRGBO(241, 242, 243, 1),
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                          ),
                          inputItem(context, 'Calculation Option',
                              TextEditingController(), search2_data)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Text(
                            'RESET ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(0, 0, 0, 1),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          // fixedSize: Size(370.0, 40.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Text(
                            'UNDO ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(0, 0, 0, 1),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          // fixedSize: Size(370.0, 40.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          delete(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Text(
                            'REMOVE ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(0, 0, 0, 1),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          // fixedSize: Size(370.0, 40.0),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 15.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black54),
                    children: [
                      TableRow(children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Item POS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'ALU',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'UPC',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'VEND CODE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'DESCRIPTION',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'PRICE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'COST',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'ITEM COST',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'QUANTITY',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(26, 61, 109, 1),
                              Color.fromRGBO(38, 88, 187, 1),
                            ],
                          )),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Store Quantity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                        ),
                      ]),
                      /* Tableitem(
                          '11', '11', '11', '', '', '11', '', '', '11', '11')*/
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: products_items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Table(
                      border: TableBorder.all(color: Colors.black54),
                      children: [
                        TableRow(children: [
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].itempos,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].alu,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].upc,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].vendcode,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].description,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].price.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].cost.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].itemcost.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                          Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ), Container(
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    products_items[index].quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                        ]),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
            height: 80,
            padding: EdgeInsets.only(bottom: 5, right: 15, left: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Flexible(
                    child: inputItem2('Quantity', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('Price', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('Cost', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('Tax', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('SubTotal', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('FEE', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('Disk', nameController),
                  ),
                  new Flexible(
                    child: inputItem2('Total', nameController),
                  ),
                ])));
  }

  TableRow Tableitem(
      String text1,
      String text2,
      String text3,
      String text4,
      String text5,
      String text6,
      String text7,
      String text8,
      String text9,
      String text10) {
    return TableRow(children: [
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text1,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text2,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text3,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text4,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text5,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text6,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text7,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text8,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text9,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text10,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        )),
      ),
    ]);
  }

  Widget inputItem(BuildContext context, String text,
      TextEditingController txtControl, List<String> data,
      {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: EasyAutocomplete(
                controller: txtControl,
                suggestions: data,
                onChanged: (value) => print('onChanged value: $value'),
                onSubmitted: (value) {

                  print('onSubmitted value: $value');
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Choose Item To Add ..'),
                          content: ChooseDialog(context,value),
                        );
                      });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget inputItem2(String text, TextEditingController txtControl,
      {bool isPassword = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ChooseDialog(BuildContext context,String value) {
    List<Product> search_products_list = [];
    if (selectedValue == "ALU") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].alu) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "UPC") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].upc) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "ITEM POS") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].itempos) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "VEND CODE") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].vendcode) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "DESCRIPTION") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].description) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "PRICE") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].price.toString()) {
          search_products_list.add(products_list[i]);
        }
      }
    }else if (selectedValue == "COST") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].cost.toString()) {
          search_products_list.add(products_list[i]);
        }
      }
    }else if (selectedValue == "ITEM COST") {
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].itemcost.toString()) {
          search_products_list.add(products_list[i]);
        }
      }
    }else{
      for (int i = 0; i < products_list.length; i++) {
        if (value == products_list[i].alu||value == products_list[i].upc||value == products_list[i].itempos||value == products_list[i].vendcode) {
          search_products_list.add(products_list[i]);
        }
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height -
          150, // Change as per your requirement
      width: MediaQuery.of(context).size.width -
          150, // Change as per your requirement
      child: Column(
        children: [
          Table(
            border: TableBorder.all(color: Colors.black54),
            children: [
              TableRow(children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Item POS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'ALU',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'UPC',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'VEND CODE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'DESCRIPTION',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'PRICE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'COST',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'ITEM COST',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(26, 61, 109, 1),
                      Color.fromRGBO(38, 88, 187, 1),
                    ],
                  )),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'QUANTITY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  )),
                ),
              ]),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: search_products_list.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  if(products_items.contains(search_products_list[index])){
                   // print('available');
                    for(int i=0;i<products_items.length;i++){
                      if(products_items[i].id==search_products_list[index].id){
                        double quantity=products_items[i].quantity;
                        products_items[i].quantity=quantity+1;
                        setState(() {
                        });
                        break;

                      }
                    }
                  }else{
                    products_items.add( search_products_list[index]);
                  }

                  setState(() {
                  });
                },
                child: Table(
                  border: TableBorder.all(color: Colors.black54),
                  children: [
                    TableRow(children: [
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].itempos,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].alu,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].upc,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].vendcode,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].description,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].cost.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].itemcost.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                      Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            search_products_list[index].quantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        )),
                      ),
                    ]),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void delete(BuildContext context) {
  AwesomeDialog(
    context: context,
    width: 500,
    dialogType: DialogType.ERROR,
    headerAnimationLoop: false,
    animType: AnimType.TOPSLIDE,
    showCloseIcon: true,
    closeIcon: const Icon(Icons.clear),
    title: 'Delete ?',
    desc:
        'Dialog description here..................................................',
    btnCancelOnPress: () {},
    onDissmissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
    btnOkOnPress: () {},
  ).show();
}
