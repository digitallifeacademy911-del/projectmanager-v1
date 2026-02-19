import 'package:flutter/material.dart';
import 'package:projectmanager/common/theme/pallette.dart';

class Messenger {
  static void showSuccess(BuildContext context, Widget child) {
    
    final messenger = ScaffoldMessenger.of(context);

    messenger.clearMaterialBanners();

    messenger.showMaterialBanner(
      MaterialBanner(
        elevation: 2,
        content: child,
        backgroundColor: PalleteColor.successColor,
        leading: Icon(Icons.abc),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: TextButton(
              onPressed: () {
                messenger.hideCurrentMaterialBanner();
              },
              child: const Text(
                'DISMISS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      try {
        messenger.hideCurrentMaterialBanner();
      } catch (e) {
        debugPrint("Banner already dismissed");
      }
    });
  }
}
