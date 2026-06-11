import 'dart:async';
import 'dart:ui';
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

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  String _displayText = '';
  final String _fullText = 'Flutter Developer';
  int _charIndex = 0;
  Timer? _timer;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_charIndex < _fullText.length) {
        if (mounted) {
          setState(() {
            _displayText += _fullText[_charIndex];
            _charIndex++;
          });
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final padding = AppSizes.responsivePadding(context);

    return FadeTransition(
      opacity: _fadeAnim,
      child: Container(
        constraints: const BoxConstraints(minHeight: 800),
        padding: EdgeInsets.fromLTRB(padding, 140, padding, 80),
        child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 12, child: _buildHeroContent()),
        const SizedBox(width: 40),
        Expanded(flex: 10, child: _buildHeroVisual()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildHeroVisual(),
        const SizedBox(height: 60),
        _buildHeroContent(),
      ],
    );
  }

  Widget _buildHeroContent() {
    final isMobile = AppSizes.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Premium Badge
        _buildBadge(),
        const SizedBox(height: 24),
        
        // Greeting
        Text(
          "Hey, I'm",
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 32 : 54,
            fontWeight: FontWeight.w300,
            letterSpacing: -1,
          ),
        ),
        
        // Name with Gradient and Shine
        _buildAnimatedName(),
        
        const SizedBox(height: 16),
        
        // Typing Terminal
        _buildTerminal(),
        
        const SizedBox(height: 32),
        
        // Bio
        Text(
          'Architecting high-performance cross-platform experiences.\nTurning visionary concepts into production-ready digital products with Flutter.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? 15 : 18,
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
        
        const SizedBox(height: 48),
        
        // Action Buttons
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.purple.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulsingDot(),
          const SizedBox(width: 10),
          const Text(
            'Open for new opportunities',
            style: TextStyle(
              color: AppColors.purpleLight,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedName() {
    final isMobile = AppSizes.isMobile(context);
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFC084FC), Color(0xFFF472B6), Color(0xFF60A5FA)],
      ).createShader(bounds),
      child: Text(
        'Abu Rasel',
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 48 : 86,
          fontWeight: FontWeight.w900,
          height: 1.0,
          letterSpacing: -2,
        ),
      ),
    );
  }

  Widget _buildTerminal() {
    final isMobile = AppSizes.isMobile(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FontAwesomeIcons.terminal, color: AppColors.purple, size: 14),
          const SizedBox(width: 12),
          Text(
            _displayText,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 16 : 22,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w500,
            ),
          ),
          _BlinkingCursor(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      spacing: 20,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _HeroCTA(
          label: 'View Portfolio',
          onTap: widget.onViewWork,
          isPrimary: true,
        ),
        _HeroCTA(
          label: 'Download CV',
          onTap: widget.onDownloadCV,
          isPrimary: false,
          icon: FontAwesomeIcons.fileArrowDown,
        ),
      ],
    );
  }

  Widget _buildHeroVisual() {
    final isMobile = AppSizes.isMobile(context);
    final size = isMobile ? 280.0 : 450.0;
    
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Floating background glow
            _FloatingGlow(size: size * 0.8),
            
            // Rotating Orbits
            _OrbitalLayer(radius: size, duration: 30, color: AppColors.purple.withOpacity(0.1)),
            _OrbitalLayer(radius: size * 0.75, duration: 20, color: AppColors.pink.withOpacity(0.1), reverse: true),
            
            // Main Avatar with Perspective
            AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 15 * _floatController.value),
                  child: child,
                );
              },
              child: _buildAvatar(size * 0.5),
            ),
            
            // Floating Tech Icons
            _FloatingTechBadge(icon: FontAwesomeIcons.flutter, color: AppColors.blue, offset: const Offset(-0.8, -0.6)),
            _FloatingTechBadge(icon: FontAwesomeIcons.fire, color: AppColors.orange, offset: const Offset(0.8, -0.4)),
            _FloatingTechBadge(icon: FontAwesomeIcons.code, color: AppColors.green, offset: const Offset(-0.7, 0.7)),
            _FloatingTechBadge(icon: FontAwesomeIcons.bolt, color: AppColors.purple, offset: const Offset(0.7, 0.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(0.4),
            blurRadius: 40,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.purple, AppColors.pink, AppColors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF0F0F16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.network(
              "https://avatars.githubusercontent.com/u/136594114?v=4",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCTA extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final IconData? icon;

  const _HeroCTA({required this.label, required this.onTap, required this.isPrimary, this.icon});

  @override
  State<_HeroCTA> createState() => _HeroCTAState();
}

class _HeroCTAState extends State<_HeroCTA> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.purplePinkGradient : null,
            color: widget.isPrimary ? null : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isPrimary ? Colors.transparent : Colors.white.withOpacity(0.1),
            ),
            boxShadow: _isHovered && widget.isPrimary
                ? [BoxShadow(color: AppColors.purple.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 10),
                Icon(widget.icon, color: Colors.white, size: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrbitalLayer extends StatefulWidget {
  final double radius;
  final int duration;
  final Color color;
  final bool reverse;

  const _OrbitalLayer({required this.radius, required this.duration, required this.color, this.reverse = false});

  @override
  State<_OrbitalLayer> createState() => _OrbitalLayerState();
}

class _OrbitalLayerState extends State<_OrbitalLayer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.duration))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: widget.reverse ? ReverseAnimation(_controller) : _controller,
      child: Container(
        width: widget.radius,
        height: widget.radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: widget.color, width: 1),
        ),
      ),
    );
  }
}

class _FloatingTechBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Offset offset;

  const _FloatingTechBadge({required this.icon, required this.color, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(offset.dx, offset.dy),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF13131C).withOpacity(0.9),
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 10)],
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}

class _FloatingGlow extends StatelessWidget {
  final double size;
  const _FloatingGlow({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.purple.withOpacity(0.15),
            Colors.transparent,
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

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _anim, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)));
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat(reverse: true);
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) { return FadeTransition(opacity: _ctrl, child: Container(width: 2, height: 24, margin: const EdgeInsets.only(left: 4), color: AppColors.purple)); }
}
