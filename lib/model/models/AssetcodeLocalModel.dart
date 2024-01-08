import 'package:flutter/material.dart';

class LocalStassetcodeModel {
  String? assetcode;


  LocalStassetcodeModel({this.assetcode});

  LocalStassetcodeModel.fromJson(Map<String, dynamic> json) {
    assetcode = json['assetcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetcode'] = this.assetcode;
    return data;
  }
}

