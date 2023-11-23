import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var idAsalProv = "".obs;
  var idAsalCity = "".obs;
  var idTujuanProv = "".obs;
  var idTujuanCity = "".obs;
  var berat = "".obs;
  var kodeKurir = "".obs;
  List<Ongkir> dataOngkir = [];

  void cekOngkir() async {
    if (idAsalProv != "0" &&
        idTujuanProv != "0" &&
        idAsalCity != "0" &&
        idTujuanCity != "0" &&
        kodeKurir != "" &&
        berat != "") {
      //eksekusi
      try {
        var res = await http.post(
          Uri.parse('https://api.rajaongkir.com/starter/cost'),
          headers: {
            'key': '9980f436ef35a0ba78c1d3beba2c5b94',
            'content-type': 'application/x-www-form-urlencoded',
          },
          body: {
            "origin": idAsalCity.value,
            "destination": idTujuanCity.value,
            "weight": berat.value,
            "courier": kodeKurir.value,
          },
        );

        List data =
            json.decode(res.body)['rajaongkir']['results'][0]['costs'] as List;
        dataOngkir = Ongkir().fromJsonList(data);

        Get.defaultDialog(
          title: "Ongkos Kirim " + kodeKurir.value,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dataOngkir
                .map(
                  (e) => ListTile(
                    title: Text(e.service.toString()),
                    subtitle: Text(e.description.toString()),
                    trailing: Text("Rp. " + e.cost![0].value.toString()),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Tidak dapat mengecek ongkos kirim",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(e.toString());
      }
    } else {
      Get.snackbar(
        "Error",
        "Data tidak boleh kosong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void showLoading() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    Future.delayed(
      Duration(milliseconds: 200),
      () => Get.offAndToNamed("/home"),
    );
  }
}
