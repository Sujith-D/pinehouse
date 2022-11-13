import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinehouse/Model/detailsModel.dart';


class Database {
  final _db = FirebaseFirestore.instance;
  Future uploadData(details data) async{

    final json = {
      'Name' : data.name,
      'Phone Number' : data.phone,
      'Position' : data.position,
      'ImageURL' : data.imageLink,
      'Age' : data.age
    };

    await _db.collection('Profile').add(json);
  }
}