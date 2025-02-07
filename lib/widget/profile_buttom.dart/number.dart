import 'dart:ui';

import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({super.key, this.age, this.rate, this.order});
  final int? age;
  final int? rate;
  final int? order;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, rate.toString(), S.of(context).ranking),
          buildDivider(),
          buildButton(context, order.toString(), S.of(context).orders),
          buildDivider(),
          buildButton(context, age.toString(), S.of(context).age),
        ],
      );
  Widget buildDivider() => SizedBox(
        height: 24,
        child: const VerticalDivider(
          color: Colors.black,
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
