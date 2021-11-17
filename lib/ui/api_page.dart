import 'dart:convert';

import 'package:awesome_currency_app/constants/colors.dart';
import 'package:awesome_currency_app/list_of_flag_names/flag_list.dart';
import 'package:awesome_currency_app/model/currency_model.dart';
import 'package:awesome_currency_app/responsive/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatelessWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cpink,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: getProportionateScreenWidth(60.0),
          ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: getProportionateScreenWidth(15.0),
                ),
                Text(
                  "Valyuta Kurslari",
                  style: TextStyle(
                      color: tcpink,
                      fontSize: getProportionateScreenWidth(25.0),
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: getProportionateScreenWidth(450.0),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: cwhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                  ),
                  child: FutureBuilder(
                    future: _getData(),
                    builder: (context, AsyncSnapshot<List<Currency>> snap) {
                      var data = snap.data;
                      return snap.hasData
                          ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: getProportionateScreenWidth(30.0),
                                      backgroundImage: AssetImage(
                                        "assets/images/" +
                                            Flag.Country_Names[index] +
                                            ".png",
                                      ),
                                    ),
                                    title: Text(
                                      data[index].title.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(data[index].date.toString(),
                                        style:
                                            const TextStyle(color: Colors.black)),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          data[index].code.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: corange,
                                          ),
                                        ),
                                        Text(
                                          data[index].cbPrice.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: CupertinoActivityIndicator(),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
