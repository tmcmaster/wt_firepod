import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

mixin ComponentBuilders {
  static SideBuilder sideIcon(IconData icon) {
    return (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Icon(
          icon,
          color: Colors.blue,
          size: constraints.maxWidth / 3,
        ),
      );
    };
  }

  static HeaderBuilder headerIcon(IconData icon) {
    return (context, constraints, shrinkOffset) {
      return Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 40),
        child: Icon(
          icon,
          color: Colors.blue,
          size: constraints.maxWidth / 4 * (1 - shrinkOffset),
        ),
      );
    };
  }

  static HeaderBuilder headerImage(String assetName) {
    return (context, constraints, _) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset(assetName),
      );
    };
  }

  static SideBuilder sideImage(String assetName) {
    return (context, constraints) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(constraints.maxWidth / 4),
          child: Image.asset(assetName),
        ),
      );
    };
  }
}
