import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class Section extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;
  final Color background;
  final Key? anchorKey;

  const Section({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
    required this.child,
    this.background = AppColors.white,
    this.anchorKey,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pad = width < 700 ? 20.0 : 48.0;

    return ColoredBox(
      key: anchorKey,
      color: background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: EdgeInsets.fromLTRB(pad, 72, pad, 72),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eyebrow != null)
                  Text(
                    eyebrow!.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.rose,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.2,
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(height: 8),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.muted,
                        height: 1.5,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
