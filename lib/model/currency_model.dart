import 'dart:convert';

List<Currency> currencyFromJson(String str) => List<Currency>.from(json.decode(str).map((x) => Currency.fromJson(x)));

String currencyToJson(List<Currency> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currency {
    Currency({
        required this.title,
        required this.code,
        required this.cbPrice,
        required this.nbuBuyPrice,
        required this.nbuCellPrice,
        required this.date,
    });

    String title;
    String code;
    String cbPrice;
    String nbuBuyPrice;
    String nbuCellPrice;
    String date;

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        title: json["title"],
        code: json["code"],
        cbPrice: json["cb_price"],
        nbuBuyPrice: json["nbu_buy_price"],
        nbuCellPrice: json["nbu_cell_price"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "cb_price": cbPrice,
        "nbu_buy_price": nbuBuyPrice,
        "nbu_cell_price": nbuCellPrice,
        "date": date,
    };
}
