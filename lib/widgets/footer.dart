import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_theme.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final padding = AppSizes.responsivePadding(context);
    final year = DateTime.now().year;
    final navItems = ['Home', 'Work', 'Skills', 'Journey', 'Connect'];

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.purple.withOpacity(0.04),
            Colors.transparent,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 48),
      child: Column(
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BrandSection(),
                    const SizedBox(height: 32),
                    _NavSection(navItems: navItems),
                    const SizedBox(height: 32),
                    _SocialSection(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _BrandSection()),
                    Expanded(child: _NavSection(navItems: navItems)),
                    Expanded(child: _SocialSection()),
                  ],
                ),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withOpacity(0.05)),
          const SizedBox(height: 24),
          isMobile
              ? Column(
                  children: [
                    Text('© $year Abu Rasel. All rights reserved.',
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 13)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Crafted with ',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 13)),
                        const Icon(Icons.favorite,
                            color: AppColors.pink, size: 14),
                        const Text(' using Flutter',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 13)),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('© $year Abu Rasel. All rights reserved.',
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 13)),
                    Row(
                      children: const [
                        Text('Crafted with ',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 13)),
                        Icon(Icons.favorite,
                            color: AppColors.pink, size: 14),
                        Text(' using Flutter',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.purplePinkGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(FontAwesomeIcons.star,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.purplePinkGradient.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: const Text(
                'Abu Rasel',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Creating exceptional mobile experiences with Flutter.\nLet\'s build something amazing together.',
          style: TextStyle(
              color: AppColors.textSecondary, fontSize: 13, height: 1.6),
        ),
      ],
    );
  }
}

class _NavSection extends StatelessWidget {
  final List<String> navItems;
  const _NavSection({required this.navItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Navigation',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: navItems
              .map(
                (item) => GestureDetector(
                  onTap: () {},
                  child: Text(
                    item,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 14),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _SocialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Connect With Me',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Row(
          children: [
            _SocialIcon(
              icon: FontAwesomeIcons.github,
              gradient: const LinearGradient(
                  colors: [Color(0xFF374151), Color(0xFF4B5563)]),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: FontAwesomeIcons.linkedin,
              gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)]),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.email_rounded,
              gradient: AppColors.purplePinkGradient,
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final LinearGradient gradient;
  const _SocialIcon({required this.icon, required this.gradient});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(widget.icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
