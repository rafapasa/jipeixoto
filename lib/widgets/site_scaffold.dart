import 'package:flutter/material.dart';

import '../config/brand.dart';
import '../theme/app_theme.dart';
import 'brand_logo.dart';
import 'buttons.dart';

class SiteScaffold extends StatelessWidget {
  final Widget child;
  final void Function(String section) onNavigate;

  const SiteScaffold({
    super.key,
    required this.child,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 900;

    return Scaffold(
      backgroundColor: AppColors.white,
      endDrawer: compact
          ? Drawer(
              backgroundColor: AppColors.white,
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const BrandLogo(height: 56),
                    const SizedBox(height: 16),
                    const Text('Menu',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18)),
                    const SizedBox(height: 16),
                    for (final item in _items)
                      ListTile(
                        title: Text(item.label),
                        onTap: () {
                          Navigator.pop(context);
                          onNavigate(item.id);
                        },
                      ),
                    const SizedBox(height: 12),
                    RoseButton(
                      label: 'WhatsApp',
                      icon: Icons.chat_bubble_outline,
                      onTap: () => openUrl(Brand.whatsappUrl),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          Column(
            children: [
              _TopBar(compact: compact, onNavigate: onNavigate),
              Expanded(child: child),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                _Fab(
                  color: const Color(0xFF25D366),
                  icon: Icons.chat,
                  tooltip: 'WhatsApp',
                  onTap: () => openUrl(Brand.whatsappUrl),
                ),
                const SizedBox(height: 10),
                _Fab(
                  color: AppColors.roseDeep,
                  icon: Icons.camera_alt_outlined,
                  tooltip: 'Instagram',
                  onTap: () => openUrl(Brand.instagramUrl),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String id;
  final String label;
  const _NavItem(this.id, this.label);
}

const _items = [
  _NavItem('inicio', 'Início'),
  _NavItem('produtos', 'Produtos'),
  _NavItem('videos', 'Vídeos'),
  _NavItem('instagram', 'Instagram'),
  _NavItem('contato', 'Contato'),
];

class _TopBar extends StatelessWidget {
  final bool compact;
  final void Function(String section) onNavigate;

  const _TopBar({required this.compact, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 32, vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => onNavigate('inicio'),
            child: BrandLogo(height: compact ? 88 : 116, compact: true),
          ),
          const Spacer(),
          if (!compact) ...[
            for (final item in _items)
              TextButton(
                onPressed: () => onNavigate(item.id),
                child: Text(
                  item.label,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            RoseButton(
              label: 'WhatsApp',
              icon: Icons.chat_bubble_outline,
              compact: true,
              onTap: () => openUrl(Brand.whatsappUrl),
            ),
          ] else
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.menu),
              ),
            ),
        ],
      ),
    );
  }
}

class _Fab extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _Fab({
    required this.color,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color,
        shape: const CircleBorder(),
        elevation: 6,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 54,
            height: 54,
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
