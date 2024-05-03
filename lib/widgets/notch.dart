import 'package:flutter/cupertino.dart';

class NotchWidget {
  CupertinoListTile build({
    required String title,
    VoidCallback? onTap,
    IconData? leading,
    IconData? trailing,
    String? subtitle,
  }) {
    return CupertinoListTile.notched(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
      leading: Icon(leading, size: 20),
      trailing: Icon(trailing, size: 20),
      onTap: onTap,
    );
  }
}
