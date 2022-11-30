import 'package:flutter/material.dart';

loading(context) => showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
        ));
