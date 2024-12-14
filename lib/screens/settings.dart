import 'package:flutter/material.dart';
import 'package:v1/widget/navBarr.dart';

import '../generated/l10n.dart';

class Settings_page extends StatelessWidget {
  const Settings_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).setings),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: Text(
              "صفحه هيتم اضافه  الربط بها بعد تجهيز الداتا بيز",
              style: TextStyle(fontSize: 30),
            )),
            Spacer(
              flex: 1,
            ),
            CustomNavBar(
              more: true,
            )
          ],
        ));
  }
}
