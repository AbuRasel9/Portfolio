import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_theme.dart';

class PortfolioNavbar extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String) onNavTap;

  const PortfolioNavbar({
    super.key,
    required this.scrollController,
    required this.onNavTap,
  });

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar> {
  bool _isScrolled = false;
  bool _mobileMenuOpen = false;

  final navItems = ['Home', 'Work', 'Skills', 'Journey', 'Connect'];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _isScrolled = widget.scrollController.offset > 50;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;
    return Positioned(
      top: 24,
      left: 0,
      right: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_mobileMenuOpen && isMobile ? 24 : 100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: _isScrolled
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.95,
              constraints: BoxConstraints(
                maxWidth: _isScrolled ? 800 : 1000,
              ),
              decoration: BoxDecoration(
                color: _isScrolled
                    ? const Color(0xFF07070C).withValues(alpha: 0.75)
                    : const Color(0xFF07070C).withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(_mobileMenuOpen && isMobile ? 24 : 100),
                border: Border.all(color: AppColors.borderLight),
                boxShadow: _isScrolled
                    ? [
                        BoxShadow(
                          color: AppColors.purple.withValues(alpha: 0.12),
                          blurRadius: 30,
                          spreadRadius: 0,
                        )
                      ]
                    : [],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo (Interactive - scrolls to Home)
                        GestureDetector(
                          onTap: () => widget.onNavTap('Home'),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.purplePinkGradient,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.star,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      AppColors.purplePinkGradient.createShader(bounds),
                                  blendMode: BlendMode.srcIn,
                                  child: const Text(
                                    'Abu Rasel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Desktop Nav
                        if (!isMobile)
                          Row(
                            children: navItems
                                .map(
                                  (item) => _NavItem(
                                    label: item,
                                    onTap: () => widget.onNavTap(item),
                                  ),
                                )
                                .toList(),
                          ),

                        // CTA Button or Hamburger
                        if (!isMobile)
                          _GradientButton(
                            label: "Let's Talk",
                            onTap: () => widget.onNavTap('Connect'),
                          )
                        else
                          IconButton(
                            onPressed: () =>
                                setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                            icon: Icon(
                              _mobileMenuOpen ? Icons.close : Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Mobile Menu
                  if (isMobile && _mobileMenuOpen)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0F).withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        children: [
                          ...navItems.map(
                            (item) => ListTile(
                              title: Text(
                                item,
                                style: const TextStyle(color: AppColors.textSecondary),
                              ),
                              onTap: () {
                                setState(() => _mobileMenuOpen = false);
                                widget.onNavTap(item);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: _GradientButton(
                              label: "Let's Talk",
                              onTap: () {
                                setState(() => _mobileMenuOpen = false);
                                widget.onNavTap('Connect');
                              },
                              fullWidth: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovered ? Colors.white : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _GradientButton({
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: widget.fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.purplePinkGradient,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: AppColors.purple.withValues(alpha: 0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
