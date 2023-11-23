import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../data/models/city_model.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../controllers/home_controller.dart';

class DropdownSearchCityView extends GetView<HomeController> {
  const DropdownSearchCityView({
    required this.title,
    required this.asal,
    required this.endPoint,
  });

  final String title;
  final bool asal;
  final String endPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch<City>(
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: this.title,
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Get.theme.backgroundColor),
              ),
            ),
          ),
          asyncItems: (text) async {
            //cek apakah asal/tujuan
            String idProv = asal
                ? controller.idAsalProv.value
                : controller.idTujuanProv.value;

            //ambil data dengan dio
            var res = await Dio().get(
              this.endPoint + idProv,
              queryParameters: {
                'key': '9980f436ef35a0ba78c1d3beba2c5b94',
              },
            );

            //konversi list data json ke model
            return City().fromJsonList(res.data['rajaongkir']['results']);
          },
          popupProps: PopupProps.menu(
            showSearchBox: true,
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(item.cityName.toString()),
              );
            },
          ),
          onChanged: (value) {
            print(value?.toJson());
            if (asal) {
              controller.idAsalCity.value = value?.cityId ?? "0";
            } else {
              print("Masuk Kota Tujuan");
              controller.idTujuanCity.value = value?.cityId ?? "0";
            }
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
