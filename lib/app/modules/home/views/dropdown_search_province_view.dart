import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/province_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';
import '../controllers/home_controller.dart';

class DropdownSearchProvinceView extends GetView<HomeController> {
  const DropdownSearchProvinceView({
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
        DropdownSearch<Province>(
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
            //ambil data dengan dio
            var res = await Dio().get(
              this.endPoint,
              queryParameters: {
                'key': '9980f436ef35a0ba78c1d3beba2c5b94',
              },
            );

            //konversi list data json ke model
            return Province().fromJsonList(res.data['rajaongkir']['results']);
          },
          popupProps: PopupProps.menu(
            showSearchBox: true,
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(item.province.toString()),
              );
            },
          ),
          onChanged: (value) {
            print(value?.toJson());
            if (asal) {
              controller.idAsalProv.value = value?.provinceId ?? "0";
            } else {
              print("Masuk Province Tujuan");
              controller.idTujuanProv.value = value?.provinceId ?? "0";
            }
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
