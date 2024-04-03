import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 토스트 메시지 출력.
var showToast = (String message) => {
      Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorRes.primary.withOpacity(0.9),
        fontSize: 16,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      )
    };
