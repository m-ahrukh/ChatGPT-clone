import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/chat_widget.dart';
import 'package:flutter_application/widgets/drop_down.dart';
import 'package:flutter_application/widgets/text_widget.dart';

import '../constants/constants.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
              bottom: Radius.circular(20),
        )),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
         builder: (context) {
          return const Padding(
              padding: EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: TextWidget(
                    label: "Choose Model: ",
                    fontSize: 16,
                  )),
                  Flexible(flex: 2, child: ModelsDropDownWidget())
                ],
              ));
        });
  }
}
