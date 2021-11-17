import 'package:awesome_currency_app/constants/colors.dart';
import 'package:awesome_currency_app/responsive/size_config.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cpink,
      body: Column(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  Text(
                    "Dastur Haqida",
                    style: TextStyle(
                        color: tcpink,
                        fontSize: getProportionateScreenWidth(20.0),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Dastur 'NBU' bankining ma'lumotlar bazasi orqali internet bilan 100% aniqlikda ishlaydi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: tcpink,
                        fontSize: getProportionateScreenWidth(20.0),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Ushbu Dastur sizga ayni hozirgi vaqtdagi Valyuta kurslarini hisoblashda yordam beradi.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: tcpink,
                        fontSize: getProportionateScreenWidth(20.0),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: Text(
                      "Muallif: Samandar Abduhamitov",
                      style: TextStyle(
                          color: tcpink,
                          fontSize: getProportionateScreenWidth(20.0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
