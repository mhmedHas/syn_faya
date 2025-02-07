import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

PreferredSize buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;

  return PreferredSize(
    preferredSize: const Size.fromHeight(120), // Set the height here
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30), // Adjust the corner radius as needed
        bottomRight: Radius.circular(30),
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).profile_nav,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
