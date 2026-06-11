import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_theme.dart';

class PortfolioFooter extends StatelessWidget {
  final Function(String) onNavTap;

  const PortfolioFooter({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;
    final padding = AppSizes.responsivePadding(context);
    final year = DateTime.now().year;
    final navItems = ['Home', 'Work', 'Skills', 'Journey', 'Connect'];

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColors.purple.withValues(alpha: 0.03),
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
                    const _BrandSection(),
                    const SizedBox(height: 32),
                    _NavSection(navItems: navItems, onNavTap: onNavTap),
                    const SizedBox(height: 32),
                    const _SocialSection(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 3, child: _BrandSection()),
                    Expanded(flex: 2, child: _NavSection(navItems: navItems, onNavTap: onNavTap)),
                    const Expanded(flex: 2, child: _SocialSection()),
                  ],
                ),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withValues(alpha: 0.05)),
          const SizedBox(height: 24),
          isMobile
              ? Column(
                  children: [
                    Text('© $year Abu Rasel. All rights reserved.',
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 13)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Crafted with ',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 13)),
                        const Icon(Icons.favorite,
                            color: AppColors.pink, size: 14),
                        const Text(' using Flutter Web',
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
                        Text(' using Flutter Web',
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
  const _BrandSection();

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
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Junior Flutter Developer specialized in architecting exceptionally beautiful and high-performance cross-platform mobile & web applications.',
          style: TextStyle(
              color: AppColors.textSecondary, fontSize: 13, height: 1.6),
        ),
      ],
    );
  }
}

class _NavSection extends StatelessWidget {
  final List<String> navItems;
  final Function(String) onNavTap;

  const _NavSection({required this.navItems, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Navigation',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: navItems
              .map(
                (item) => _NavFooterLink(
                  label: item,
                  onTap: () => onNavTap(item),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _NavFooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavFooterLink({required this.label, required this.onTap});

  @override
  State<_NavFooterLink> createState() => _NavFooterLinkState();
}

class _NavFooterLinkState extends State<_NavFooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _hovered ? Colors.white : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _SocialSection extends StatelessWidget {
  const _SocialSection();

  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Connect With Me',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2)),
        const SizedBox(height: 16),
        Row(
          children: [
            _SocialIcon(
              icon: FontAwesomeIcons.github,
              gradient: const LinearGradient(
                  colors: [Color(0xFF374151), Color(0xFF4B5563)]),
              onTap: () => _launchURL('https://github.com/AbuRasel9'),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: FontAwesomeIcons.linkedin,
              gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)]),
              onTap: () => _launchURL('https://www.linkedin.com/in/abu-rasel-76b3b5220'),
            ),
            const SizedBox(width: 12),
            _SocialIcon(
              icon: Icons.email_rounded,
              gradient: AppColors.purplePinkGradient,
              onTap: () => _launchURL('mailto:aburasel.ptsl@gmail.com?subject=Project Inquiry'),
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
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.12 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: widget.gradient.colors[0].withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: Icon(widget.icon, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
