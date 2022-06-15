import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:voucher/models/Product.dart';
import 'package:voucher/models/voucher/ProductModel.dart';

import 'dart:convert';

import '../../network/ApiUrl.dart';
import '../../network/HttpClient.dart';
import '../models/RecieveModel.dart';
import '../models/RecieveModel2.dart';
import '../models/RecieveStartModel.dart';
import '../models/voucher/Store.dart';
import '../models/voucher/Data.dart';

class Voucher_screen extends StatefulWidget {
  @override
  _Voucher_screenState createState() => _Voucher_screenState();
}

class _Voucher_screenState extends State<Voucher_screen> {
  final ScrollController _controller = ScrollController();
  FocusNode _focusNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isHiddenPassword = true;
  String? selectedValue;
  String? selectedValue2;
  String? selectedstore;
  String? selectedtype;
  List<String> items = [
    'ALL',
    'ALU',
    'UPC',
    'VEND CODE',
    'DESC',
    'PRICE',
    'COST',
    'ITEM COST',
    'STR QTY',
  ];
  List<String> stores = [];
  List<String> types = ["Recieve", "Return"];

  List<String> items2 = [
    'Empty',
    'C',
    'CX',
    'P',
    'PX',
    'TC',
    'TP',
  ];
  List<String> search_data = [];
  List<String> search2_data = [];
  List<ProductInfo> products_items = [];

  TextEditingController search_controller = new TextEditingController();
  TextEditingController search2_controller = new TextEditingController();
  List<ProductInfo> products_list = [];
  bool allcheck = false;
  double fee_value = 0.0;

  bool loading = true;
  var num = "";

  @override
  void initState() {
    super.initState();
    getdata();
    getdata2();
  }

  getdata() {
    HttpClient().get(
        ApiUrl.apiUrl +
        'api/backoffice/inventory?cols=* ',       headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Session': ApiUrl.auth_session,
          //'Auth-Nonce': ApiUrl.auth_nonce,
          //'Auth-Nonce-Response': ApiUrl.auth_nonce_response,
          'Accept-Language':
              'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        }).then((value) {
      print(value);
      ProductModel rm = ProductModel.fromJson(value);
      List<DataModel> itemsList = rm.data!;

      print(itemsList.length.toString());
      setState(() {
        loading = false;
      });

      // products_list.clear();

      for (int i = 0; i < itemsList.length; i++) {
        String alu = itemsList[i].alu == null ? "" : itemsList[i].alu;
        String upc = itemsList[i].upc == null ? "" : itemsList[i].upc;
        String vendorcode =
            itemsList[i].vendorcode == null ? "" : itemsList[i].vendorcode;
        String description1 = itemsList[i].description1 == null
            ? "desc$i"
            : itemsList[i].description1;
        String lottype = itemsList[i].lottype == null
            ? ""
            : itemsList[i].lottype==0?"None": itemsList[i].lottype==4?"Partial": itemsList[i].lottype==8?"Full":"";
        double cost = itemsList[i].cost == null ? 0.0 : itemsList[i].cost;
        double orgin_cost = itemsList[i].lastrcvdcost;
        double price =
            itemsList[i].fstprice == null ? 0.0 : itemsList[i].fstprice;

        ProductInfo pro = new ProductInfo(
            i.toString(),
            itemsList[i].sid,
            alu,
            upc,
            vendorcode,
            description1,
            "",
            0.0,
            "",
            price,
            price,
            cost,
            cost,
            cost,
            orgin_cost,
            1,
            1,
            1,
            1,
            "",
            "",
            false,
            15,
            23,
            10,
            lottype,
            "",
            "",
            false);
        products_list.add(pro);
      }
    });
  }

  List<Store> storesList = [];
  var ssid = "";

  getdata2() {
    setState(() {
      loading = true;
    });
    HttpClient()
        .get(ApiUrl.apiUrl + 'v1/rest/store?cols=*', headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json, version=2',
      'Auth-Session': ApiUrl.auth_session,
      'Accept-Language':
          'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
    }).then((value) {
      print(value);
      storesList = List<Store>.from(value.map((i) => Store.fromJson(i)));
      ssid = storesList.first.subsidiarySid;
      getdata3(storesList.first.subsidiarySid);

      print(storesList.length.toString());
      setState(() {
        loading = false;
      });

      // products_list.clear();

      for (int i = 0; i < storesList.length; i++) {
        stores.add(storesList[i].storeName.toString());
      }
      setState(() {});
    });
  }

  getdata3(String sbssid) {
    setState(() {
      loading = true;
    });
    var body = {
      "data": [
        {"originapplication": "RProPrismWeb", "isBlank": true, "VouType": selectedtype=="Recieve"?0:1, "sbssid": sbssid,/*"StoreSid":getstoreid(selectedstore.toString())*/}
      ]
    };
    HttpClient().get(ApiUrl.apiUrl + 'api/backoffice/receiving?cols=sid&sort=createddatetime,desc&page_size=1',
       // body: json.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Session': ApiUrl.auth_session,
          'Accept-Language':
              'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        }).then((value) {
      print(value);
      RecieveStartModel rm = RecieveStartModel.fromJson(value);
      setState(() {
        num = rm.data!.first.sid;
      });
      print("\n" + "\n" + "\n" + num+ "\n" + "\n" + "\n");
      setState(() {
        loading = false;
      });

      // products_list.clear();
      setState(() {});
    });
  }

  sendItems(String sbssid,BuildContext context) {
    setState(() {
      loading = true;
    });
    var body = {
      "data": [
        for (int i = 0; i < products_items.length; i++)
            {
              "originapplication": "RProPrismWeb",
              "itemsid": products_items[i].itemsid,
              "vousid": num,
             "lotnumber": products_items[i].lot_number, //string
              //"lottype": products_items[i].lot_type,  //0-4-8
              "lotexipydate": products_items[i].lotDate,
              "serialno": products_items[i].serial,
              "qty": products_items[i].quantity,
              "cost": products_items[i].cost,
              "price": products_items[i].price,
            },
      ]
    };
    HttpClient().post(ApiUrl.apiUrl + 'api/backoffice/receiving/$num/recvitem',
        body: json.encode(body),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json, version=2',
          'Auth-Session': ApiUrl.auth_session,
          'Accept-Language':
              'en-US,en-SA;q=0.9,en;q=0.8,ar-US;q=0.7,ar;q=0.6,ur-US;q=0.5,ur;q=0.4,en-GB;q=0.3',
        }).then((value) {
      print(value);
      RecieveModel2 rm = RecieveModel2.fromJson(value);


      setState(() {
        loading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: rm.errors!=null?Colors.red:Colors.green,
            content: Container(
            height:200,
            width:300,
            child: Center(
              child: 
                Text(
                rm.errors!=null?rm.errors.toString().substring(108,200):"Voucher Items Sent Sucessfully To Prism ",
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                ),
            ),));});
      // products_list.clear();
      setState(() {});
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  int getstoreid(String selected){
    int selected_index=0;
    for (int i=0;i<storesList.length;i++){
      if(selected==storesList[i].storeName){
        selected_index=storesList[i].sid;
        return storesList[i].sid ;
      }else{
        continue;
      }
    }
    return selected_index;
  }
  var _focusNodes = [];

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _controller.animateTo(offset - 200,
            duration: Duration(milliseconds: 30), curve: Curves.ease);
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _controller.animateTo(offset + 200,
            duration: Duration(milliseconds: 30), curve: Curves.ease);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _focusNodes = List.generate(products_items.length, (index) => FocusNode());

    int row = products_items.length;
    int col = 10;

    var twoDList = List.generate(
        row, (i) => List.generate(col, (j) => FocusNode(), growable: false));

    if (selectedValue == null) {
      search_data.clear();
      for (int i = 0; i < products_list.length; i++) {
        search_data.add(products_list[i].alu);
        search_data.add(products_list[i].description);
        search_data.add(products_list[i].upc);
        setState(() {});
      }
    }

    double totalquantity = 0;
    if (products_items.length > 0) {
      for (int i = 0; i < products_items.length; i++) {
        totalquantity += products_items[i].quantity;
      }
    }
    TextEditingController quantity_con =
        TextEditingController(text: totalquantity.toStringAsFixed(3));

    double totalcost = 0;
    if (products_items.length > 0) {
      for (int i = 0; i < products_items.length; i++) {
        totalcost += products_items[i].ext_cost;
      }
    }
    TextEditingController total_cost_con =
        TextEditingController(text: totalcost.toStringAsFixed(3));

    double totalprice = 0;
    if (products_items.length > 0) {
      for (int i = 0; i < products_items.length; i++) {
        totalprice += products_items[i].ext_price;
      }
    }
    TextEditingController totalprice_con =
        TextEditingController(text: totalprice.toStringAsFixed(3));

    double totaltax = 0;
    if (products_items.length > 0) {
      for (int i = 0; i < products_items.length; i++) {
        totaltax += (products_items[i].quantity * products_items[i].cost) *
            (products_items[i].tax_perc / 100);
      }
    }
    TextEditingController totaltax_con =
        TextEditingController(text: totaltax.toStringAsFixed(3));

    TextEditingController subtotal_con = TextEditingController(
        text: (double.parse(totaltax_con.text) +
                double.parse(total_cost_con.text))
            .toStringAsFixed(3));

    TextEditingController fee_con = TextEditingController(text: "0");
    TextEditingController total_con = TextEditingController(
        text:
            (fee_value + double.parse(subtotal_con.text)).toStringAsFixed(3) + " SAR");
    List<String> coulmns = [
      "#",
      "ALU",
      "UPC",
      "VEND CODE",
      "DESC",
      "BOUNS",
      "FLAG",
      "FLAG VAL",
      "PRICE",
      "COST",
      "QTY",
      "EXT PRICE",
      "EXT COST",
      "TAX PERC",
      "TAX EXT",
      "COST & TAX",
      "MARGIN",
      "EXT MARGIN",
      "ITEM COST",
      "ORGIN CODE",
      "STR QTY",
      "LOT EXPDATE",
      "LOT NOTE",
      "LOT TYPE",
      "LOT NUM",
      "SERIAL",
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: RawKeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKey: _handleKeyEvent,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 100),
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
                          'Sid: $num',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Row(
                            children: [
                             /* Expanded(
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
                                                Icons.store,
                                                size: 16,
                                                color: Color.fromRGBO(
                                                    26, 61, 109, 1),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Stores',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        26, 61, 109, 1),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: stores
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            26, 61, 109, 1),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedstore,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedstore = value as String;

                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor:
                                              Color.fromRGBO(26, 61, 109, 1),
                                          iconDisabledColor: Colors.grey,
                                          buttonHeight: 50,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Center(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: const [
                                              Icon(
                                                Icons.info,
                                                size: 16,
                                                color: Color.fromRGBO(
                                                    26, 61, 109, 1),
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Voucher Type',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        26, 61, 109, 1),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: types
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            26, 61, 109, 1),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedtype,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedtype = value as String;

                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor:
                                              Color.fromRGBO(26, 61, 109, 1),
                                          iconDisabledColor: Colors.grey,
                                          buttonHeight: 50,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),*/
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
                                                color: Color.fromRGBO(
                                                    26, 61, 109, 1),
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
                                                    color: Color.fromRGBO(
                                                        26, 61, 109, 1),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: items
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            26, 61, 109, 1),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedValue,
                                          onChanged: (value) {
                                            search_controller.text = "";
                                            setState(() {
                                              selectedValue = value as String;
                                              setState(() {
                                                search_data.clear();
                                              });
                                              if (selectedValue == "ALL") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i].alu);
                                                  search_data.add(
                                                      products_list[i]
                                                          .description);
                                                  search_data.add(
                                                      products_list[i].upc);
                                                  search_data.add(
                                                      products_list[i]
                                                          .vendcode);
                                                  setState(() {});
                                                }
                                              } else if (selectedValue ==
                                                  "ALU") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i].alu);
                                                }
                                              } else if (selectedValue ==
                                                  "UPC") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i].upc);
                                                }
                                              } else if (selectedValue ==
                                                  "VEND CODE") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i]
                                                          .vendcode);
                                                }
                                              } else if (selectedValue ==
                                                  "DESCRIPTION") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i]
                                                          .description);
                                                }
                                              } else if (selectedValue ==
                                                  "PRICE") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i]
                                                          .price
                                                          .toString());
                                                }
                                              } else if (selectedValue ==
                                                  "COST") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i]
                                                          .cost
                                                          .toString());
                                                }
                                              } else if (selectedValue ==
                                                  "ITEM COST") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i]
                                                          .itemcost
                                                          .toString());
                                                }
                                              } else if (selectedValue ==
                                                  "STR QTY") {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i]
                                                          .storequantity
                                                          .toString());
                                                }
                                              } else {
                                                for (int i = 0;
                                                    i < products_list.length;
                                                    i++) {
                                                  search_data.add(
                                                      products_list[i].alu);
                                                  search_data.add(
                                                      products_list[i]
                                                          .description);
                                                  search_data.add(
                                                      products_list[i].upc);
                                                  setState(() {});
                                                }
                                              }
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor:
                                              Color.fromRGBO(26, 61, 109, 1),
                                          iconDisabledColor: Colors.grey,
                                          buttonHeight: 50,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                    ),
                                    inputItem(
                                        context,
                                        'Search by',
                                        search_controller,
                                        search_data.toSet().toList())
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
                                                color: Color.fromRGBO(
                                                    26, 61, 109, 1),
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
                                                    color: Color.fromRGBO(
                                                        26, 61, 109, 1),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: items2
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            26, 61, 109, 1),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedValue2,
                                          onChanged: (value) {
                                            if (value == "C") {
                                              for (int i = 0;
                                                  i < products_items.length;
                                                  i++) {
                                                if (products_items[i].flag ==
                                                        "" &&
                                                    products_items[i]
                                                            .flag_val !=
                                                        0) {
                                                  products_items[i].cost =
                                                      products_items[i].price -
                                                          products_items[i]
                                                              .flag_val;
                                                  setState(() {});
                                                }
                                              }
                                            } else if (value == "CX") {
                                              for (int i = 0;
                                                  i < products_items.length;
                                                  i++) {
                                                if (products_items[i].flag ==
                                                        "" &&
                                                    products_items[i]
                                                            .flag_val !=
                                                        0) {
                                                  products_items[i].cost =
                                                      products_items[i].price *
                                                          (products_items[i]
                                                                  .flag_val /
                                                              100);
                                                  setState(() {});
                                                }
                                              }
                                            } else if (value == "P") {
                                              for (int i = 0;
                                                  i < products_items.length;
                                                  i++) {
                                                if (products_items[i].flag ==
                                                        "" &&
                                                    products_items[i]
                                                            .flag_val !=
                                                        0) {
                                                  products_items[i].price =
                                                      products_items[i].cost +
                                                          products_items[i]
                                                              .flag_val;
                                                  setState(() {});
                                                }
                                              }
                                            } else if (value == "PX") {
                                              for (int i = 0;
                                                  i < products_items.length;
                                                  i++) {
                                                if (products_items[i].flag ==
                                                        "" &&
                                                    products_items[i]
                                                            .flag_val !=
                                                        0) {
                                                  products_items[i]
                                                      .price = products_items[i]
                                                          .cost +
                                                      products_items[i].cost *
                                                          (products_items[i]
                                                                  .flag_val /
                                                              100);
                                                  setState(() {});
                                                }
                                              }
                                            } else if (value == "TC") {
                                              for (int i = 0;
                                                  i < products_items.length;
                                                  i++) {
                                                if (products_items[i].flag ==
                                                        "" &&
                                                    products_items[i]
                                                            .flag_val !=
                                                        0) {
                                                  products_items[i].cost =
                                                      products_items[i]
                                                              .flag_val /
                                                          products_items[i]
                                                              .quantity;
                                                  setState(() {});
                                                }
                                              }
                                            } else if (value == "TC") {
                                              for (int i = 0;
                                                  i < products_items.length;
                                                  i++) {
                                                if (products_items[i].flag ==
                                                        "" &&
                                                    products_items[i]
                                                            .flag_val !=
                                                        0) {
                                                  products_items[i].ext_price =
                                                      products_items[i]
                                                          .flag_val;
                                                  products_items[i].price =
                                                      products_items[i]
                                                              .flag_val /
                                                          products_items[i]
                                                              .quantity;
                                                  setState(() {});
                                                }
                                              }
                                            }
                                            setState(() {
                                              selectedValue2 = value as String;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor:
                                              Color.fromRGBO(26, 61, 109, 1),
                                          iconDisabledColor: Colors.grey,
                                          buttonHeight: 50,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Color.fromRGBO(
                                                241, 242, 243, 1),
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              reset(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, bottom: 15),
                                              child: Text(
                                                'RESET ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  Color.fromRGBO(0, 0, 0, 1),

                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
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
                                              undo(context,
                                                  products_items.length - 1);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, bottom: 15),
                                              child: Text(
                                                'UNDO ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  Color.fromRGBO(0, 0, 0, 1),

                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
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
                                              padding: const EdgeInsets.only(
                                                  top: 15.0, bottom: 15),
                                              child: Text(
                                                'REMOVE ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  Color.fromRGBO(0, 0, 0, 1),

                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              // fixedSize: Size(370.0, 40.0),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromRGBO(26, 61, 109, 1),
                                            Color.fromRGBO(38, 88, 187, 1),
                                          ],
                                        ),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                      ),
                                      padding: EdgeInsets.all(3),
                                      child: Checkbox(
                                        value: allcheck,
                                        onChanged: (value) {
                                          print(value!);
                                          allcheck = value;
                                          for (int i = 0;
                                              i < products_items.length;
                                              i++) {
                                            products_items[i].checked = value;
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    for (int i = 0; i < coulmns.length; i++)
                                      Expanded(
                                        flex: coulmns[i] == "#"
                                            ? 1
                                            : coulmns[i] == "DESC"
                                                ? 4
                                                : coulmns[i] == "QTY" ||
                                                        coulmns[i] ==
                                                            "STR QTY" ||
                                                        coulmns[i] ==
                                                            "VEND CODE" ||
                                                        coulmns[i] ==
                                                            "TAX PERC" ||
                                                        coulmns[i] == "FLAG" ||
                                                        coulmns[i] ==
                                                            "FLAG VAL" ||
                                                        coulmns[i] == "BOUNS"
                                                    ? 2
                                                    : 3,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: Container(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: Text(
                                                coulmns[i],
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  width:
                                      MediaQuery.of(context).size.width * 1.5,
                                  child: ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1.5,
                                                  height: 0,
                                                  color: Colors.black),
                                      itemCount: products_items.length,
                                      itemBuilder: (context, index) {
                                        TextEditingController price_con =
                                            TextEditingController(
                                                text: products_items[index]
                                                    .price
                                                    .toString());
                                        TextEditingController cost_con =
                                            TextEditingController(
                                                text: products_items[index]
                                                    .cost
                                                    .toString());

                                        FocusNode f1 = twoDList[index][0];
                                        FocusNode f2 = twoDList[index][1];
                                        FocusNode f3 = twoDList[index][2];
                                        FocusNode f4 = twoDList[index][3];
                                        FocusNode f5 = twoDList[index][4];
                                        FocusNode f6 = twoDList[index][5];
                                        FocusNode f7 = twoDList[index][6];
                                        FocusNode f8 = twoDList[index][7];
                                        FocusNode f9 = twoDList[index][8];
                                        FocusNode f10 = twoDList[index][9];

                                        return Container(
                                          color: index % 2 == 0
                                              ? Colors.white
                                              : Colors.black12,
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Checkbox(
                                                  value: allcheck ||
                                                      products_items[index]
                                                          .checked,
                                                  onChanged: (value) {
                                                    print(value!);
                                                    products_items[index]
                                                        .checked = value;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index].alu,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index].upc,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .vendcode,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .description,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: RawKeyboardListener(
                                                  child: Container(
                                                    child: TextField(
                                                      focusNode: f1,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      // Moves focus to next.
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor:
                                                            Colors.black26,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                      onSubmitted: (s) {
                                                        if (s == "B") {
                                                          products_items[index]
                                                              .tax_perc = 0;
                                                          products_items[index]
                                                              .ext_cost = 0;
                                                        } else if (s == "BT") {
                                                          //  double a= getproductDatabyid(products_items[index].id)!.cost*products_items[index].quantity;
                                                          products_items[index]
                                                              .ext_cost = 0;
                                                          setState(() {});

                                                          products_items[index]
                                                              .tax_ext = ((products_items[
                                                                              index]
                                                                          .quantity *
                                                                      products_items[
                                                                              index]
                                                                          .cost) *
                                                                  products_items[
                                                                          index]
                                                                      .tax_perc) /
                                                              100;
                                                        } else {
                                                          products_items[index]
                                                                  .tax_perc =
                                                              getproductDatabyid(
                                                                      products_items[
                                                                              index]
                                                                          .id)!
                                                                  .tax_perc;
                                                          products_items[index]
                                                                  .ext_cost =
                                                              products_items[
                                                                          index]
                                                                      .quantity *
                                                                  products_items[
                                                                          index]
                                                                      .cost;
                                                          setState(() {});

                                                          products_items[index]
                                                              .tax_ext = ((products_items[
                                                                              index]
                                                                          .quantity *
                                                                      products_items[
                                                                              index]
                                                                          .cost) *
                                                                  products_items[
                                                                          index]
                                                                      .tax_perc) /
                                                              100;
                                                        }
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  focusNode: FocusNode(),
                                                  onKey: (RawKeyEvent event) {
                                                    print(event
                                                        .data.logicalKey.keyId);
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968066)) {}
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968067)) {
                                                      f2.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968068)) {
                                                      twoDList[index - 1][0]
                                                          .requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968065)) {
                                                      twoDList[index + 1][0]
                                                          .requestFocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: RawKeyboardListener(
                                                  child: Container(
                                                    child: TextFormField(
                                                      focusNode: f2,
                                                      initialValue:
                                                          products_items[index]
                                                              .flag,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      // Moves focus to next.
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor:
                                                            Colors.black26,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                      onChanged: (s) {
                                                        setState(() {
                                                          products_items[index]
                                                              .flag = s;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  focusNode: FocusNode(),
                                                  onKey: (RawKeyEvent event) {
                                                    print(event
                                                        .data.logicalKey.keyId);
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968066)) {
                                                      f1.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968067)) {
                                                      f3.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968068)) {
                                                      twoDList[index - 1][1]
                                                          .requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968065)) {
                                                      twoDList[index + 1][1]
                                                          .requestFocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: RawKeyboardListener(
                                                  child: Container(
                                                    child: TextFormField(
                                                      focusNode: f3,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      // Moves focus to next.
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor:
                                                            Colors.black26,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                      onChanged: (s) {
                                                        if (s == "") {
                                                          products_items[index]
                                                              .cost = getproductDatabyid(
                                                                  products_items[
                                                                          index]
                                                                      .id)!
                                                              .cost;
                                                          products_items[index]
                                                                  .price =
                                                              getproductDatabyid(
                                                                      products_items[
                                                                              index]
                                                                          .id)!
                                                                  .price;
                                                        } else {
                                                          if (products_items[
                                                                      index]
                                                                  .flag !=
                                                              "") {
                                                            if (products_items[
                                                                        index]
                                                                    .flag ==
                                                                "C") {
                                                              products_items[
                                                                      index]
                                                                  .cost = products_items[
                                                                          index]
                                                                      .price -
                                                                  double.parse(
                                                                      s);
                                                              setState(() {
                                                                cost_con.text =
                                                                    products_items[
                                                                            index]
                                                                        .cost
                                                                        .toString();
                                                              });
                                                            } else if (products_items[
                                                                        index]
                                                                    .flag ==
                                                                "CX") {
                                                              products_items[
                                                                      index]
                                                                  .cost = products_items[
                                                                          index]
                                                                      .price *
                                                                  (double.parse(
                                                                          s) /
                                                                      100);
                                                              setState(() {
                                                                cost_con.text =
                                                                    products_items[
                                                                            index]
                                                                        .cost
                                                                        .toString();
                                                              });
                                                            } else if (products_items[
                                                                        index]
                                                                    .flag ==
                                                                "P") {
                                                              products_items[
                                                                          index]
                                                                      .price =
                                                                  products_items[
                                                                              index]
                                                                          .cost +
                                                                      double
                                                                          .parse(
                                                                              s);
                                                              setState(() {
                                                                price_con.text =
                                                                    products_items[
                                                                            index]
                                                                        .price
                                                                        .toString();
                                                              });
                                                            } else if (products_items[
                                                                        index]
                                                                    .flag ==
                                                                "PX") {
                                                              products_items[
                                                                      index]
                                                                  .price = products_items[
                                                                          index]
                                                                      .cost +
                                                                  products_items[
                                                                              index]
                                                                          .cost *
                                                                      (double.parse(
                                                                              s) /
                                                                          100);
                                                              setState(() {
                                                                price_con.text =
                                                                    products_items[
                                                                            index]
                                                                        .price
                                                                        .toString();
                                                              });
                                                            } else if (products_items[
                                                                        index]
                                                                    .flag ==
                                                                "TP") {
                                                              products_items[
                                                                          index]
                                                                      .ext_price =
                                                                  double.parse(
                                                                      s);
                                                              products_items[
                                                                      index]
                                                                  .price = double
                                                                      .parse(
                                                                          s) /
                                                                  products_items[
                                                                          index]
                                                                      .quantity;
                                                              setState(() {});
                                                            } else if (products_items[
                                                                        index]
                                                                    .flag ==
                                                                "TC") {
                                                              products_items[
                                                                      index]
                                                                  .cost = double
                                                                      .parse(
                                                                          s) /
                                                                  products_items[
                                                                          index]
                                                                      .quantity;
                                                              setState(() {});
                                                            }
                                                          } else {
                                                            if (products_items[
                                                                        index]
                                                                    .bouns ==
                                                                "B") {
                                                              products_items[
                                                                      index]
                                                                  .tax_perc = 0;
                                                              products_items[
                                                                      index]
                                                                  .ext_cost = 0;
                                                            } else if (products_items[
                                                                        index]
                                                                    .bouns ==
                                                                "BT") {
                                                              //  double a= getproductDatabyid(products_items[index].id)!.cost*products_items[index].quantity;
                                                              products_items[
                                                                      index]
                                                                  .ext_cost = 0;
                                                              setState(() {});

                                                              products_items[
                                                                      index]
                                                                  .tax_ext = ((products_items[index]
                                                                              .quantity *
                                                                          products_items[index]
                                                                              .cost) *
                                                                      products_items[
                                                                              index]
                                                                          .tax_perc) /
                                                                  100;
                                                            } else {
                                                              products_items[
                                                                          index]
                                                                      .tax_perc =
                                                                  getproductDatabyid(
                                                                          products_items[index]
                                                                              .id)!
                                                                      .tax_perc;
                                                              products_items[
                                                                      index]
                                                                  .ext_cost = products_items[
                                                                          index]
                                                                      .quantity *
                                                                  products_items[
                                                                          index]
                                                                      .cost;
                                                              setState(() {});

                                                              products_items[
                                                                      index]
                                                                  .tax_ext = ((products_items[index]
                                                                              .quantity *
                                                                          products_items[index]
                                                                              .cost) *
                                                                      products_items[
                                                                              index]
                                                                          .tax_perc) /
                                                                  100;
                                                            }
                                                          }
                                                          setState(() {
                                                            products_items[
                                                                        index]
                                                                    .flag_val =
                                                                double.parse(s);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  focusNode: FocusNode(),
                                                  onKey: (RawKeyEvent event) {
                                                    print(event
                                                        .data.logicalKey.keyId);
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968066)) {
                                                      f2.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968067)) {
                                                      f4.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968068)) {
                                                      twoDList[index - 1][2]
                                                          .requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968065)) {
                                                      twoDList[index + 1][2]
                                                          .requestFocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: RawKeyboardListener(
                                                  child: Container(
                                                    child: TextFormField(
                                                      controller: price_con,
                                                      focusNode: f4,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      // Moves focus to next.

                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      onChanged: (s) {
                                                        products_items[index]
                                                                .price =
                                                            double.parse(
                                                                s.toString());
                                                        products_items[index]
                                                                .ext_price =
                                                            products_items[
                                                                        index]
                                                                    .price *
                                                                products_items[
                                                                        index]
                                                                    .quantity;
                                                        setState(() {});
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor:
                                                            Colors.black26,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  focusNode: FocusNode(),
                                                  onKey: (RawKeyEvent event) {
                                                    print(event
                                                        .data.logicalKey.keyId);
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968066)) {
                                                      f3.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968067)) {
                                                      f5.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968068)) {
                                                      twoDList[index - 1][3]
                                                          .requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968065)) {
                                                      twoDList[index + 1][3]
                                                          .requestFocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  child: RawKeyboardListener(
                                                    child: TextFormField(
                                                      controller: cost_con,
                                                      focusNode: f5,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      // Moves focus to next.

                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      onChanged: (s) {
                                                        setState(() {
                                                          products_items[index]
                                                                  .cost =
                                                              double.parse(s!);
                                                          products_items[index]
                                                                  .ext_cost =
                                                              products_items[
                                                                          index]
                                                                      .quantity *
                                                                  double.parse(
                                                                      s!);
                                                        });
                                                      },
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor:
                                                            Colors.black26,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    focusNode: FocusNode(),
                                                    onKey: (RawKeyEvent event) {
                                                      print(event.data
                                                          .logicalKey.keyId);
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968066)) {
                                                        f4.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968067)) {
                                                        f6.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968068)) {
                                                        twoDList[index - 1][4]
                                                            .requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968065)) {
                                                        twoDList[index + 1][4]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: RawKeyboardListener(
                                                  child: Container(
                                                    child: TextFormField(
                                                      focusNode: f6,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      // Moves focus to next.
                                                      initialValue:
                                                          products_items[index]
                                                              .quantity
                                                              .toString(),
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      onChanged: (s) {
                                                        products_items[index]
                                                                .quantity =
                                                            double.parse(
                                                                s.toString());

                                                        products_items[index]
                                                                .ext_price =
                                                            products_items[
                                                                        index]
                                                                    .price *
                                                                products_items[
                                                                        index]
                                                                    .quantity;
                                                        products_items[index]
                                                                .ext_cost =
                                                            products_items[
                                                                        index]
                                                                    .cost *
                                                                products_items[
                                                                        index]
                                                                    .quantity;
                                                        setState(() {});
                                                      },
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        filled: true,
                                                        fillColor:
                                                            Colors.black26,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 14.0,
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  focusNode: FocusNode(),
                                                  onKey: (RawKeyEvent event) {
                                                    print(event
                                                        .data.logicalKey.keyId);
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968066)) {
                                                      f5.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968067)) {
                                                      f7.requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968068)) {
                                                      twoDList[index - 1][5]
                                                          .requestFocus();
                                                    }
                                                    if (event.runtimeType ==
                                                            RawKeyDownEvent &&
                                                        (event.logicalKey
                                                                .keyId ==
                                                            4294968065)) {
                                                      twoDList[index + 1][5]
                                                          .requestFocus();
                                                    }
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      (products_items[index]
                                                              .ext_price)
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      (products_items[index]
                                                              .ext_cost)
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .tax_perc
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      ((products_items[index]
                                                                      .quantity *
                                                                  products_items[
                                                                          index]
                                                                      .cost) *
                                                              (products_items[
                                                                          index]
                                                                      .tax_perc /
                                                                  100))
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      (products_items[index]
                                                                  .ext_cost +
                                                              ((products_items[
                                                                              index]
                                                                          .quantity *
                                                                      products_items[
                                                                              index]
                                                                          .cost) *
                                                                  (products_items[
                                                                              index]
                                                                          .tax_perc /
                                                                      100)))
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      (products_items[index]
                                                                  .price -
                                                              products_items[
                                                                      index]
                                                                  .cost)
                                                          .toStringAsFixed(3)
                                                          .toString()
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      (products_items[index]
                                                                  .ext_price -
                                                              products_items[
                                                                      index]
                                                                  .ext_cost)
                                                          .toStringAsFixed(3)
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .itemcost
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .origincost
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .storequantity
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: RawKeyboardListener(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2),
                                                      child: TextFormField(
                                                        focusNode: f7,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        // Moves focus to next.
                                                        initialValue:
                                                            products_items[
                                                                    index]
                                                                .lotDate
                                                                .toString(),
                                                        maxLength: 6,
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        onChanged: (s) {
                                                          products_items[index]
                                                                  .lotDate =
                                                              s.toString();
                                                          setState(() {});
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: 'yymmdd',
                                                          filled: true,
                                                          counterText: "",
                                                          fillColor:
                                                              Colors.black26,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 14.0,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .lightBlueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    focusNode: FocusNode(),
                                                    onKey: (RawKeyEvent event) {
                                                      print(event.data
                                                          .logicalKey.keyId);
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968066)) {
                                                        f6.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968067)) {
                                                        f8.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968068)) {
                                                        twoDList[index - 1][6]
                                                            .requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968065)) {
                                                        twoDList[index + 1][6]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 2),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Text(
                                                      products_items[index]
                                                          .price
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: RawKeyboardListener(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2),
                                                      child: TextFormField(
                                                        enabled: false,
                                                        focusNode: f8,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        // Moves focus to next.
                                                        initialValue:
                                                            products_items[
                                                                    index]
                                                                .lot_type
                                                                .toString(),
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        onChanged: (s) {
                                                          products_items[index]
                                                                  .lot_type =
                                                              s.toString();
                                                          setState(() {});
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Colors.black26,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 14.0,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .lightBlueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    focusNode: FocusNode(),
                                                    onKey: (RawKeyEvent event) {
                                                      print(event.data
                                                          .logicalKey.keyId);
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968066)) {
                                                        f7.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968067)) {
                                                        f9.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968068)) {
                                                        twoDList[index - 1][7]
                                                            .requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968065)) {
                                                        twoDList[index + 1][7]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: RawKeyboardListener(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2),
                                                      child: TextFormField(
                                                        focusNode: f9,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        // Moves focus to next.
                                                        initialValue:
                                                            products_items[
                                                                    index]
                                                                .lot_number
                                                                .toString(),
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        onChanged: (s) {
                                                          products_items[index]
                                                                  .lot_number =
                                                              s.toString();
                                                          setState(() {});
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Colors.black26,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 14.0,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .lightBlueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    focusNode: FocusNode(),
                                                    onKey: (RawKeyEvent event) {
                                                      print(event.data
                                                          .logicalKey.keyId);
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968066)) {
                                                        f8.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968067)) {
                                                        f10.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968068)) {
                                                        twoDList[index - 1][8]
                                                            .requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968065)) {
                                                        twoDList[index + 1][8]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: RawKeyboardListener(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2),
                                                      child: TextField(
                                                        focusNode: f10,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        // Moves focus to next.
                                                        keyboardType: TextInputType
                                                            .numberWithOptions(
                                                                decimal: true),
                                                        onChanged: (s) {
                                                          products_items[index]
                                                                  .serial =
                                                              s.toString();
                                                          setState(() {});
                                                        },
                                                        onSubmitted: (v) {
                                                          _focusNodes[index + 1]
                                                              .requestFocus();
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          filled: true,
                                                          fillColor:
                                                              Colors.black26,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 14.0,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .blueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .lightBlueAccent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    focusNode: FocusNode(),
                                                    onKey: (RawKeyEvent event) {
                                                      print(event.data
                                                          .logicalKey.keyId);
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968066)) {
                                                        f9.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968067)) {
                                                        f1.requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968068)) {
                                                        twoDList[index - 1][9]
                                                            .requestFocus();
                                                      }
                                                      if (event.runtimeType ==
                                                              RawKeyDownEvent &&
                                                          (event.logicalKey
                                                                  .keyId ==
                                                              4294968065)) {
                                                        twoDList[index + 1][9]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  )),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomSheet: Container(
            height: 100,
            padding: EdgeInsets.only(bottom: 5, right: 15, left: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new Flexible(
                    child: inputItem2('Quantity', quantity_con, false),
                  ),
                  new Flexible(
                    child: inputItem2('Price', totalprice_con, false),
                  ),
                  new Flexible(
                    child: inputItem2('Cost', total_cost_con, false),
                  ),
                  new Flexible(
                    child: inputItem2('Tax', totaltax_con, false),
                  ),
                 /* new Flexible(
                    child: inputItem2('SubTotal', subtotal_con, false),
                  ),*/
                 /* new Flexible(
                    child: feeinputItem('FEE', fee_con, true),
                  ),*/
                  /* new Flexible(
                    child: inputItem2('Discount', nameController, false),
                  ),*/
                  new Flexible(
                    child: inputItem2('Total', total_con, false),
                  ),
                  new Flexible(
                    child: new ElevatedButton(
                      onPressed: () async {
                        sendItems(ssid,context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(19),
                        child: Text(
                          'Update Voucher',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        // fixedSize: Size(370.0, 40.0),
                      ),
                    ),
                  )
                ])));
  }

  Color linear = Colors.white;

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
              padding: const EdgeInsets.all(5.0),
              child: EasyAutocomplete(
                controller: txtControl,
                suggestions: data,
                onChanged: (value) => print('onChanged value: $value'),
                onSubmitted: (value) {
                  print('onSubmitted value: $value');
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Choose Item To Add ..'),
                              content: ChooseDialog(context, value),
                              actions: [
                                new ElevatedButton(
                                  onPressed: () async {
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      'Insert To Document',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    // fixedSize: Size(370.0, 40.0),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).then((value) {
                    setState(() {});
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

  Widget inputItem2(
      String text, TextEditingController txtControl, bool editable,
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
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: TextField(
              controller: txtControl,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              enabled: editable,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(26, 61, 109, 1),
                filled: true,
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

  Widget feeinputItem(
      String text, TextEditingController txtControl, bool editable,
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
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: TextFormField(
              initialValue: "0",
              onChanged: (s) {
                setState(() {
                  fee_value = double.parse(s);
                });
              },
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              enabled: editable,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(26, 61, 109, 1),
                filled: true,
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

  List<ProductInfo> search_products_list = [];
  List<bool> checked_products = [];

  Widget ChooseDialog(BuildContext context, String value) {
    search_products_list.clear();
    if (selectedValue == "ALL") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].alu.contains(value) ||
            products_list[i].upc.contains(value) ||
            products_list[i].description.contains(value) ||
            products_list[i].vendcode.contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "ALU") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].alu.contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "UPC") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].upc.contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "VEND CODE") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].vendcode.contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "DESCRIPTION") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].description.contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "PRICE") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].price.toString().contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "COST") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].cost.toString().contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else if (selectedValue == "ITEM COST") {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].itemcost.toString().contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    } else {
      for (int i = 0; i < products_list.length; i++) {
        if (products_list[i].alu.contains(value) ||
            products_list[i].upc.contains(value) ||
            products_list[i].description.contains(value) ||
            products_list[i].vendcode.contains(value)) {
          search_products_list.add(products_list[i]);
        }
      }
    }

    List<String> coulmns = [
      "ITEM POS",
      "ALU",
      "UPC",
      "VEND CODE",
      "DESCRIPTION",
      "PRICE",
      "COST",
      "QTY",
      "EXT PRICE",
      "EXT COST",
      "MARGIN",
      "EXT MARGIN",
      "ITEM COST",
      "STR QTY"
    ];
    List<bool> values = [];
    for (int i = 0; i < search_products_list.length; i++) {
      values.add(false);
    }

    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width -
            150, // Change as per your requirement
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width * 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < coulmns.length; i++)
                          Expanded(
                            flex: coulmns[i] == "ITEM POS" ||
                                    coulmns[i] == "QTY" ||
                                    coulmns[i] == "STR QTY" ||
                                    coulmns[i] == "VEND CODE"
                                ? 1
                                : 2,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Container(
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Text(
                                    coulmns[i],
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                )),
                              ),
                            ),
                          )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width * 1.5,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.5,
                                  height: 1,
                                  color: Colors.black),
                          itemCount: search_products_list.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (products_items
                                    .contains(search_products_list[index])) {
                                  print('available');
                                  for (int i = 0;
                                      i < products_items.length;
                                      i++) {
                                    if (products_items[i].id ==
                                        search_products_list[index].id) {
                                      double quantity =
                                          products_items[i].quantity;
                                      products_items[i].quantity = quantity + 1;

                                      setState(() {});

                                      //Navigator.pop(context);
                                      break;
                                    }
                                  }
                                } else {
                                  products_items
                                      .add(search_products_list[index]);
                                }
                                search_products_list[index].added = true;
                                //search_products_list[index].checked= true;

                                setState(() {});
                              },
                              child: Container(
                                color: search_products_list[index].added
                                    ? Colors.grey
                                    : Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            (index + 1).toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index].alu,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index].upc,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .vendcode,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .description,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .price
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .cost
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .quantity
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            (search_products_list[index]
                                                    .ext_price)
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            (search_products_list[index]
                                                    .ext_cost)
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            (search_products_list[index].price -
                                                    search_products_list[index]
                                                        .cost)
                                                .toString()
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            (search_products_list[index]
                                                        .ext_price -
                                                    search_products_list[index]
                                                        .ext_cost)
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .itemcost
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            search_products_list[index]
                                                .storequantity
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void undo(BuildContext context, int index) {
    AwesomeDialog(
      context: context,
      width: 500,
      dialogType: DialogType.ERROR,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.clear),
      title: 'UnDo ?',
      btnOkColor: Colors.black,
      btnCancelColor: Colors.black,
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        products_items.removeAt(index);
        setState(() {});
      },
    ).show();
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
      btnOkColor: Colors.black,
      btnCancelColor: Colors.black,
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        List<ProductInfo> products_items2 = [];

        for (int i = 0; i < products_items.length; i++) {
          if (!products_items[i].checked) {
            products_items2.add(products_items[i]);
          }
        }
        products_items = products_items2;
        setState(() {});
      },
    ).show();
  }

  ProductInfo? getproductDatabyid(String id) {
    ProductInfo pro;
    for (int i = 0; i < products_list.length; i++) {
      if (products_list[i].id == id) {
        pro = products_list[i];
        return pro;
      } else {
        continue;
      }
    }
  }

  void reset(BuildContext context) {
    AwesomeDialog(
      context: context,
      width: 500,
      dialogType: DialogType.INFO,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.refresh),
      btnOkColor: Colors.black,
      btnCancelColor: Colors.black,
      title: 'Reset ?',
      desc: 'Remove All Items From List !',
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Voucher_screen()));
      },
    ).show();
  }
}
