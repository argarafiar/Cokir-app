import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tes_ongkoskirim/app/modules/home/views/dropdown_search_city_view.dart';
import 'package:flutter_tes_ongkoskirim/app/modules/home/views/dropdown_search_province_view.dart';
import '../../../../constant/theme.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Get.bottomSheet(
              Container(
                height: 150,
                color: Get.theme.backgroundColor,
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.dark_mode_outlined,
                        color: Get.theme.iconTheme.color,
                      ),
                      title: Text(
                        "Dark Mode",
                        style: Get.theme.textTheme.bodyText1,
                      ),
                      onTap: () {
                        Get.changeThemeMode(ThemeMode.dark);
                        controller.showLoading();
                        // Get.offAllNamed("/home");
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.light_mode_outlined,
                        color: Get.theme.iconTheme.color,
                      ),
                      title: Text(
                        "Light Mode",
                        style: Get.theme.textTheme.bodyText1,
                      ),
                      onTap: () {
                        Get.changeThemeMode(ThemeMode.light);
                        controller.showLoading();
                        // Get.offAllNamed("/home");
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
          icon: Icon(Icons.light_mode_outlined),
        ),
        title: const Text(
          'COKIR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // Image(image: AssetImage("assets/img/icon_ck.png")),
          Center(
            child: Text(
              "ASAL & TUJUAN",
              style: Get.theme.textTheme.headline6,
            ),
          ),
          SizedBox(height: 20),
          DropdownSearchProvinceView(
            title: "Provinsi Asal",
            asal: true,
            endPoint: "https://api.rajaongkir.com/starter/province",
          ),
          //
          DropdownSearchCityView(
            title: "Kota Asal",
            asal: true,
            endPoint: "https://api.rajaongkir.com/starter/city?province=",
          ),
          SizedBox(height: 30),
          DropdownSearchProvinceView(
            title: "Provinsi Tujuan",
            asal: false,
            endPoint: "https://api.rajaongkir.com/starter/province",
          ),
          DropdownSearchCityView(
            title: "Kota Tujuan",
            asal: false,
            endPoint: "https://api.rajaongkir.com/starter/city?province=",
          ),
          Divider(
            color: Get.theme.backgroundColor,
            height: 20,
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "MENU",
              style: Get.theme.textTheme.headline6,
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Berat (gram)",
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Get.theme.backgroundColor),
              ),
            ),
            onChanged: (value) {
              controller.berat.value = value;
            },
          ),
          SizedBox(height: 20),
          DropdownSearch<Map<String, dynamic>>(
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kurir",
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.backgroundColor),
                ),
              ),
            ),
            items: [
              {
                "label": "JNE",
                "value": "jne",
              },
              {
                "label": "TIKI",
                "value": "tiki",
              },
              {
                "label": "POS Indonesia",
                "value": "pos",
              },
            ],
            popupProps: PopupProps.menu(
              showSearchBox: true,
              itemBuilder: (context, item, isSelected) {
                return ListTile(
                  title: Text(item["label"]),
                );
              },
            ),
            dropdownBuilder: (context, selectedItem) {
              return Text(selectedItem?["label"] ?? "Pilih Kurir");
            },
            onChanged: (value) {
              controller.kodeKurir.value = value?["value"] ?? "";
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.cekOngkir();
            },
            child: Text(
              "Cek Ongkos Kirim",
              style: Get.theme.textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
