import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// to not create a instance again & again everytime the function for checking internet connection is called.
// hence created one-time instance here
final connectionInstance = InternetConnection.createInstance();

String? defaultUserInputValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please provide the requested credentials';
  }
  if (value.trim().isEmpty) {
    return 'Only Whitespaces are not accepted';
  }
  return null;
}

Future<bool> checkInternetConnection(BuildContext context) async {
  final hasInternet = await connectionInstance.hasInternetAccess;

  if (!hasInternet) {
    final materialBanner = MaterialBanner(
      contentTextStyle: ThemeData.dark().textTheme.bodyMedium!.copyWith(
            // color: Colors.black54,
            color:const Color.fromARGB(255, 255, 111, 102),

            fontWeight: FontWeight.bold,
          ),
      backgroundColor: Colors.black54,
      onVisible: () {
        Timer(const Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).clearMaterialBanners();
        });
      },
      content: const Text(
        'No Internet Connection',
        textAlign: TextAlign.center,
      ),
      actions: [
        // because it would not let me create a MaterialBanner without any Action widget present
        GestureDetector(
          onTap: () {},
          child: const SizedBox.shrink(),
        ),
      ],
      padding: const EdgeInsetsDirectional.only(
          start: 16), // make the text a little more into Center
      dividerColor: Colors.black54,
    );

    if (context.mounted) {
      Navigator.of(context)
          .pop(); // because most-probably there will be a progress indicator dialog opened
      ScaffoldMessenger.of(context).clearMaterialBanners();
      ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
    }

    return false;
  }

  return true;
}
