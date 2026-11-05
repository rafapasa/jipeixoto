import 'package:flutter/material.dart';

import '../config/brand.dart';
import '../theme/app_theme.dart';

/// Logo 3D oficial (arquivo VXKLm.jpg).
class BrandLogo extends StatelessWidget {
  final double height;
  final bool compact;

  const BrandLogo({super.key, this.height = 56, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Brand.logoAsset,
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (_, __, ___) => compact
          ? const Text(
              'JP',
              style: TextStyle(
                color: AppColors.rose,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            )
          : const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium, color: AppColors.rose, size: 28),
                Text(
                  'Ji Peixoto',
                  style: TextStyle(
                    color: AppColors.rose,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
    );
  }
}
