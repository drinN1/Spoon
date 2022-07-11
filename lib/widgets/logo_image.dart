import 'package:flutter/material.dart';
import 'dart:convert';

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
    required this.logo,
    required this.token,
  }) : super(key: key);

  final String logo;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      cacheWidth: 200,
      logo,
      headers: {"authorization": 'Basic ${base64Encode(utf8.encode(token))}'},
    );
  }
}
