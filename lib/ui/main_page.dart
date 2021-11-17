import 'dart:convert';
import 'package:awesome_currency_app/constants/colors.dart';
import 'package:awesome_currency_app/model/currency_model.dart';
import 'package:awesome_currency_app/responsive/size_config.dart';
import 'package:awesome_currency_app/ui/api_page.dart';
import 'package:awesome_currency_app/ui/info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CurrencyApp extends StatefulWidget {
  const CurrencyApp({Key? key}) : super(key: key);

  @override
  State<CurrencyApp> createState() => _CurrencyAppState();
}

class _CurrencyAppState extends State<CurrencyApp> {
  int _currentIndexOfBottomBar = 0;
  List<Widget> _listOfWidget = [];
  Widget? infoPage, mainPage, apiPage;
  @override
  void initState() {
    super.initState();
    infoPage = InfoPage();
    mainPage = MainPage();
    apiPage = ApiPage();
    _listOfWidget = [infoPage!, mainPage!, apiPage!];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _listOfWidget[_currentIndexOfBottomBar],
      bottomNavigationBar: _bottombar(),
    );
  }

  BottomNavigationBar _bottombar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          label: "Dastur haqida",
          icon: CircleAvatar(
            backgroundColor: cgrey,
            radius: getProportionateScreenWidth(25.0),
            child: Icon(
              Icons.info_outline_rounded,
              color: cwhite,
              size: getProportionateScreenWidth(40.0),
            ),
          ),
          activeIcon: CircleAvatar(
            child: Icon(
              Icons.info_outline_rounded,
              color: cwhite,
              size: getProportionateScreenWidth(40.0),
            ),
            backgroundColor: corange,
            radius: getProportionateScreenWidth(25.0),
          ),
        ),
        BottomNavigationBarItem(
          label: "Asosiy Sahifa",
          icon: CircleAvatar(
            child: Icon(
              Icons.change_circle_outlined,
              color: cwhite,
              size: getProportionateScreenWidth(40.0),
            ),
            backgroundColor: cgrey,
            radius: getProportionateScreenWidth(25.0),
          ),
          activeIcon: CircleAvatar(
            child: Icon(
              Icons.change_circle_outlined,
              color: cwhite,
              size: getProportionateScreenWidth(40.0),
            ),
            backgroundColor: corange,
            radius: getProportionateScreenWidth(25.0),
          ),
        ),
        BottomNavigationBarItem(
          label: "Valyuta Kurslari",
          icon: CircleAvatar(
            child: Icon(
              Icons.history,
              color: cwhite,
              size: getProportionateScreenWidth(40.0),
            ),
            backgroundColor: cgrey,
            radius: getProportionateScreenWidth(25.0),
          ),
          activeIcon: CircleAvatar(
            child: Icon(
              Icons.history,
              color: cwhite,
              size: getProportionateScreenWidth(40.0),
            ),
            backgroundColor: corange,
            radius: getProportionateScreenWidth(25.0),
          ),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndexOfBottomBar,
      onTap: (i) {
        setState(() {
          _MainPageState.miqdori = '';
          _currentIndexOfBottomBar = i;
        });
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  String dropdownValue = 'USD';
  String dropdownValue2 = 'UZS';
  static String miqdori = "";
  String miqdori2 = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cpink,
      body: _mainpagebody(),
    );
  }

  Column _mainpagebody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        
        Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          height: getProportionateScreenWidth(565.52),
          decoration: const BoxDecoration(
            color: cwhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0)),
          ),
          child: _apidata(),
        ),
      ],
    );
  }

  FutureBuilder<List<Currency>> _apidata() {
    return FutureBuilder(
            future: _getData(),
            builder: (context, AsyncSnapshot<List<Currency>> snap) {
              var data = snap.data;
              return snap.hasData
                  ? _maindata(data!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            });
  }

  Column _maindata(List<Currency> data) {
    return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: getProportionateScreenWidth(15.0),
                      ),
                      Text(
                        "Valyuta Kursi",
                        style: TextStyle(
                            color: tcpink,
                            fontSize: getProportionateScreenWidth(25.0),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(20.0),
                      ),
                      Container(
                        width: getProportionateScreenWidth(330.0),
                        height: getProportionateScreenHeight(180.0),
                        color: cwhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Valyutadan:",
                              style: TextStyle(
                                fontSize:
                                    getProportionateScreenWidth(25.0),
                                color: cgrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _inputsection(data)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(20.0),
                      ),
                      Container(
                        width: getProportionateScreenWidth(330.0),
                        height: getProportionateScreenHeight(180.0),
                        color: cwhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Valyutaga:",
                              style: TextStyle(
                                fontSize:
                                    getProportionateScreenWidth(25.0),
                                color: cgrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _resultsection(data)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(50.0),
                      ),
                    ],
                  );
  }

  Container _resultsection(List<Currency> data) {
    return Container(
                            width: getProportionateScreenWidth(330.0),
                            height: getProportionateScreenWidth(80.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(1,
                                      9), // changes position of shadow
                                ),
                              ],
                              color: cwhite,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    width: getProportionateScreenWidth(
                                        180.0),
                                    child: Text(
                                      oCcy.format(double.parse(
                                          miqdori2 == ''
                                              ? '0'
                                              : miqdori2)),
                                      style: TextStyle(
                                        color: tcpink,
                                        fontSize:
                                            getProportionateScreenWidth(
                                                25.0),
                                      ),
                                    )),
                                SizedBox(
                                  height:
                                      getProportionateScreenWidth(40.0),
                                  child: const VerticalDivider(
                                      color: cgrey, thickness: 2.0),
                                ),
                                _currencyoptions(data),
                              ],
                            ),
                          );
  }

  DropdownButtonHideUnderline _currencyoptions(List<Currency> data) {
    return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue2,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: cpink,
                                  ),
                                  iconSize:
                                      getProportionateScreenWidth(
                                          34.0),
                                  style: TextStyle(
                                      color: tcpink,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenWidth(
                                              20.0)),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue2 = newValue!;
                                      if (dropdownValue == "USD" &&
                                          dropdownValue2 == "UZS") {
                                        miqdori2 =
                                            (double.parse(miqdori) *
                                                    double.parse(
                                                        data[23]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "RUB" &&
                                          dropdownValue2 == "UZS") {
                                        miqdori2 =
                                            (double.parse(miqdori) *
                                                    double.parse(
                                                        data[18]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "UZS" &&
                                          dropdownValue2 == "RUB") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    double.parse(
                                                        data[18]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "UZS" &&
                                          dropdownValue2 == "USD") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    double.parse(
                                                        data[23]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "RUB" &&
                                          dropdownValue2 == "USD") {
                                        miqdori2 = ((double.parse(
                                                        data[18]
                                                            .cbPrice) *
                                                    double.parse(
                                                        miqdori)) /
                                                double.parse(
                                                    data[23].cbPrice))
                                            .toStringAsFixed(2)
                                            .toString();
                                      } else if (dropdownValue ==
                                              "USD" &&
                                          dropdownValue2 == "RUB") {
                                        miqdori2 = ((double.parse(
                                                        miqdori) *
                                                    double.parse(data[
                                                            23]
                                                        .cbPrice)) /
                                                double.parse(
                                                    data[18].cbPrice))
                                            .toStringAsFixed(2)
                                            .toString();
                                      } else if (dropdownValue ==
                                              "UZS" &&
                                          dropdownValue2 == "UZS") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    1)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "USD" &&
                                          dropdownValue2 == "USD") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    1)
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "RUB" &&
                                          dropdownValue2 == "RUB") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    1)
                                                .toStringAsFixed(2)
                                                .toString();
                                      }
                                    });
                                  },
                                  items: <String>['USD', 'UZS', 'RUB']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
  }

  Container _inputsection(List<Currency> data) {
    return Container(
                            width: getProportionateScreenWidth(330.0),
                            height: getProportionateScreenWidth(80.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(1,
                                        9) // changes position of shadow
                                    ),
                              ],
                              color: cwhite,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(
                                      180.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r'^[0-9].[0-9]*$')
                                              .hasMatch(value)) {
                                        //  r'^[0-9]{10}$' pattern plain match number with length 10
                                        return "Enter Correct Phone Number";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (v) {
                                      setState(() {
                                        miqdori = v;

                                        if (dropdownValue == "USD" &&
                                            dropdownValue2 == "UZS") {
                                          miqdori2 =
                                              (double.parse(miqdori) *
                                                      double.parse(
                                                          data[23]
                                                              .cbPrice))
                                                  .toStringAsFixed(2)
                                                  .toString();
                                        } else if (dropdownValue ==
                                                "RUB" &&
                                            dropdownValue2 == "UZS") {
                                          miqdori2 =
                                              (double.parse(miqdori) *
                                                      double.parse(
                                                          data[18]
                                                              .cbPrice))
                                                  .toStringAsFixed(2)
                                                  .toString();
                                        } else if (dropdownValue ==
                                                "UZS" &&
                                            dropdownValue2 == "RUB") {
                                          miqdori2 =
                                              (double.parse(miqdori) /
                                                      double.parse(
                                                          data[18]
                                                              .cbPrice))
                                                  .toStringAsFixed(2)
                                                  .toString();
                                        } else if (dropdownValue ==
                                                "UZS" &&
                                            dropdownValue2 == "USD") {
                                          miqdori2 =
                                              (double.parse(miqdori) /
                                                      double.parse(
                                                          data[23]
                                                              .cbPrice))
                                                  .toStringAsFixed(2)
                                                  .toString();
                                        } else if (dropdownValue ==
                                                "RUB" &&
                                            dropdownValue2 == "USD") {
                                          miqdori2 = ((double.parse(
                                                          data[18]
                                                              .cbPrice) *
                                                      double.parse(
                                                          miqdori)) /
                                                  double.parse(
                                                      data[23].cbPrice))
                                              .toStringAsFixed(2)
                                              .toString();
                                        } else if (dropdownValue ==
                                                "USD" &&
                                            dropdownValue2 == "RUB") {
                                          miqdori2 = ((double.parse(
                                                          miqdori) *
                                                      double.parse(data[
                                                              23]
                                                          .cbPrice)) /
                                                  double.parse(
                                                      data[18].cbPrice))
                                              .toStringAsFixed(2)
                                              .toString();
                                        } else if (dropdownValue ==
                                                "UZS" &&
                                            dropdownValue2 == "UZS") {
                                          miqdori2 =
                                              (double.parse(miqdori) /
                                                      1)
                                                  .toString();
                                        } else if (dropdownValue ==
                                                "USD" &&
                                            dropdownValue2 == "USD") {
                                          miqdori2 =
                                              (double.parse(miqdori) /
                                                      1)
                                                  .toStringAsFixed(2)
                                                  .toString();
                                        } else if (dropdownValue ==
                                                "RUB" &&
                                            dropdownValue2 == "RUB") {
                                          miqdori2 =
                                              (double.parse(miqdori) /
                                                      1)
                                                  .toStringAsFixed(2)
                                                  .toString();
                                        }
                                      });
                                    },
                                    style: TextStyle(
                                      color: tcpink,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenWidth(
                                              20.0),
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      labelText: 'Pul Miqdori',
                                      labelStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: cpink,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      getProportionateScreenWidth(40.0),
                                  child: const VerticalDivider(
                                      color: cgrey, thickness: 2.0),
                                ),
                                _currencyoptions2(data),
                              ],
                            ),
                          );
  }

  DropdownButtonHideUnderline _currencyoptions2(List<Currency> data) {
    return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: corange,
                                  ),
                                  iconSize:
                                      getProportionateScreenWidth(
                                          34.0),
                                  style: TextStyle(
                                      color: tcpink,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenWidth(
                                              20.0)),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      if (dropdownValue == "USD" &&
                                          dropdownValue2 == "UZS") {
                                        miqdori2 =
                                            (double.parse(miqdori) *
                                                    double.parse(
                                                        data[23]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "RUB" &&
                                          dropdownValue2 == "UZS") {
                                        miqdori2 =
                                            (double.parse(miqdori) *
                                                    double.parse(
                                                        data[18]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "UZS" &&
                                          dropdownValue2 == "RUB") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    double.parse(
                                                        data[18]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "UZS" &&
                                          dropdownValue2 == "USD") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    double.parse(
                                                        data[23]
                                                            .cbPrice))
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "RUB" &&
                                          dropdownValue2 == "USD") {
                                        miqdori2 = ((double.parse(
                                                        data[18]
                                                            .cbPrice) *
                                                    double.parse(
                                                        miqdori)) /
                                                double.parse(
                                                    data[23].cbPrice))
                                            .toStringAsFixed(2)
                                            .toString();
                                      } else if (dropdownValue ==
                                              "USD" &&
                                          dropdownValue2 == "RUB") {
                                        miqdori2 = ((double.parse(
                                                        miqdori) *
                                                    double.parse(data[
                                                            23]
                                                        .cbPrice)) /
                                                double.parse(
                                                    data[18].cbPrice))
                                            .toStringAsFixed(2)
                                            .toString();
                                      } else if (dropdownValue ==
                                              "UZS" &&
                                          dropdownValue2 == "UZS") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    1)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "USD" &&
                                          dropdownValue2 == "USD") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    1)
                                                .toStringAsFixed(2)
                                                .toString();
                                      } else if (dropdownValue ==
                                              "RUB" &&
                                          dropdownValue2 == "RUB") {
                                        miqdori2 =
                                            (double.parse(miqdori) /
                                                    1)
                                                .toStringAsFixed(2)
                                                .toString();
                                      }
                                    });
                                  },
                                  items: <String>['USD', 'UZS', 'RUB']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
  }

  Future<List<Currency>> _getData() async {
    Uri url = Uri.parse("https://nbu.uz/uz/exchange-rates/json/");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Currency.fromJson(e))
          .toList();
    } else {
      throw Exception("Xato Bor : ${res.statusCode}");
    }
  }
}
