import 'package:flutter/material.dart';

class DidRecallApiProvider with ChangeNotifier {
  bool _didRecallApi = false;
  bool get didRecallApi => _didRecallApi;

  void setDidRecallApi(bool didRecallApi) { 
    _didRecallApi = didRecallApi;
  }
}