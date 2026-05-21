import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_theme.dart';
import 'common_widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onDownloadCV;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onDownloadCV,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  String _displayText = '';
  final String _fullText = 'Flutter Developer';
  int _charIndex = 0;
  Timer? _timer;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_charIndex < _fullText.length) {
        setState(() {
          _displayText += _fullText[_charIndex];
          _charIndex++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final isTablet = AppSizes.isTablet(context);
    final padding = AppSizes.responsivePadding(context);

    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        constraints: const BoxConstraints(minHeight: 600),
        padding: EdgeInsets.fromLTRB(padding, 120, padding, 60),
        child: isMobile || isTablet
            ? _buildMobileLayout(context)
            : _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildMainCard(context)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatsColumn()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildMainCard(context),
        const SizedBox(height: 16),
        _buildStatsColumn(),
      ],
    );
  }

  Widget _buildMainCard(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    return Stack(
      children: [
        // Glow effect
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [
                  AppColors.purple.withOpacity(0.15),
                  AppColors.pink.withOpacity(0.15),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF17171F), Color(0xFF1A1A24)],
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Available badge
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.purple.withOpacity(0.1),
                          AppColors.pink.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(color: AppColors.purple.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _PulsingDot(),
                        const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "https://avatars.githubusercontent.com/u/136594114?v=4",
                            height: 250,
                            width: 300,
                          ),
                        ),
                        // const Text(
                        //   'Available for work',
                        //   style: TextStyle(
                        //     color: AppColors.textSecondary,
                        //     fontSize: 13,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name
              Text(
                "Hey, I'm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 36 : 60,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFC084FC),
                    Color(0xFFF472B6),
                    Color(0xFFC084FC),
                  ],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  'Abu Rasel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 36 : 60,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Typing effect
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.terminal,
                    color: AppColors.purple,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _displayText,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: isMobile ? 18 : 26,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _BlinkingCursor(),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                'Crafting pixel-perfect mobile experiences with Flutter.\nTurning ideas into high-performance apps that users love.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 14 : 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // Buttons
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _HeroButton(
                    label: 'View My Work',
                    isPrimary: true,
                    onTap: widget.onViewWork,
                    icon: Icons.arrow_forward_rounded,
                  ),
                  _HeroButton(
                    label: 'Download CV',
                    isPrimary: false,
                    onTap: widget.onDownloadCV,
                    icon: FontAwesomeIcons.code,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsColumn() {
    final isMobile = AppSizes.isMobile(context);
    final stats = [
      _StatCard(
        icon: FontAwesomeIcons.star,
        value: '2+',
        label: 'Years Exp',
        description: 'Building scalable mobile apps with cutting-edge tech',
        gradient: AppColors.purplePinkGradient,
        borderColor: AppColors.purple.withOpacity(0.2),
        bgColors: [
          AppColors.purple.withOpacity(0.15),
          AppColors.bgCard,
        ],
      ),
      _StatCard(
        icon: FontAwesomeIcons.code,
        value: '15+',
        label: 'Projects',
        description: 'From concept to deployment, delivering excellence',
        gradient: const LinearGradient(
          colors: [AppColors.pink, AppColors.purple],
        ),
        borderColor: AppColors.pink.withOpacity(0.2),
        bgColors: [
          AppColors.pink.withOpacity(0.15),
          AppColors.bgCard,
        ],
      ),
      _StatCard(
        icon: FontAwesomeIcons.briefcase,
        value: '10+',
        label: 'Happy Clients',
        description: 'Trusted by startups and businesses worldwide',
        gradient: const LinearGradient(
          colors: [AppColors.blue, AppColors.cyan],
        ),
        borderColor: AppColors.blue.withOpacity(0.2),
        bgColors: [
          AppColors.blue.withOpacity(0.15),
          AppColors.bgCard,
        ],
      ),
    ];

    if (isMobile) {
      return Row(
        children: stats
            .map((s) => Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: s,
                )))
            .toList(),
      );
    }

    return Column(
      children: stats
          .map((s) =>
              Padding(padding: const EdgeInsets.only(bottom: 16), child: s))
          .toList(),
    );
  }
}

class _StatCard extends StatefulWidget {
  final IconData icon;
  final String value;
  final String label;
  final String description;
  final LinearGradient gradient;
  final Color borderColor;
  final List<Color> bgColors;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.description,
    required this.gradient,
    required this.borderColor,
    required this.bgColors,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(isMobile ? 14 : 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.bgColors,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? widget.borderColor.withOpacity(0.6)
                : widget.borderColor,
          ),
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: widget.gradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.value,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(widget.label,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 11)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: widget.gradient,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(widget.icon, color: Colors.white, size: 22),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.label,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppColors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 2,
        height: 28,
        margin: const EdgeInsets.only(left: 4),
        color: AppColors.purple,
      ),
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;
  final IconData icon;

  const _HeroButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
    required this.icon,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              gradient: widget.isPrimary ? AppColors.purplePinkGradient : null,
              color: widget.isPrimary ? null : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: widget.isPrimary
                  ? null
                  : Border.all(color: AppColors.borderLight),
              boxShadow: widget.isPrimary
                  ? [
                      BoxShadow(
                        color: AppColors.purple.withOpacity(0.3),
                        blurRadius: 20,
                      )
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(widget.icon, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
