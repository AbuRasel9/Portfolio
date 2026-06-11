import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/work_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/journey_section.dart';
import '../widgets/connect_section.dart';
import '../widgets/footer.dart';
import '../models/app_theme.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section keys for scroll navigation
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _journeyKey = GlobalKey();
  final GlobalKey _connectKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section.toLowerCase()) {
      case 'home':
        key = _homeKey;
        break;
      case 'work':
        key = _workKey;
        break;
      case 'skills':
        key = _skillsKey;
        break;
      case 'journey':
        key = _journeyKey;
        break;
      case 'connect':
        key = _connectKey;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          // Deep Space Background with Noise/Grain
          const _DeepSpaceBackground(),

          // Animated background blobs
          _BackgroundBlobs(),

          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Home / Hero
                Container(key: _homeKey),
                HeroSection(
                  onViewWork: () => _scrollToSection('work'),
                  onDownloadCV: () async {
                    final Uri uri = Uri.parse('https://github.com/AbuRasel9/Portfolio/blob/master/assets/cv/Abu%20Rasel.pdf');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                ),

                const _SectionDivider(),

                // Work
                Container(key: _workKey),
                const WorkSection(),

                const _SectionDivider(),

                // Skills
                Container(key: _skillsKey),
                const SkillsSection(),

                const _SectionDivider(),

                // Journey
                Container(key: _journeyKey),
                const JourneySection(),

                const _SectionDivider(),

                // Connect
                Container(key: _connectKey),
                const ConnectSection(),

                // Footer
                PortfolioFooter(onNavTap: _scrollToSection),
              ],
            ),
          ),

          // Floating Navbar
          PortfolioNavbar(
            scrollController: _scrollController,
            onNavTap: _scrollToSection,
          ),
        ],
      ),
    );
  }
}

class _DeepSpaceBackground extends StatelessWidget {
  const _DeepSpaceBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF030308),
      ),
      child: Stack(
        children: [
          // Very subtle grid or dots pattern
          Opacity(
            opacity: 0.03,
            child: CustomPaint(
              size: Size.infinite,
              painter: _GridPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    const spacing = 40.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _BackgroundBlobs extends StatefulWidget {
  @override
  State<_BackgroundBlobs> createState() => _BackgroundBlobsState();
}

class _BackgroundBlobsState extends State<_BackgroundBlobs>
    with TickerProviderStateMixin {
  late AnimationController _ctrl1, _ctrl2, _ctrl3;
  late Animation<double> _anim1, _anim2, _anim3;

  @override
  void initState() {
    super.initState();
    _ctrl1 = AnimationController(vsync: this, duration: const Duration(seconds: 15))
      ..repeat(reverse: true);
    _ctrl2 = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat(reverse: true);
    _ctrl3 = AnimationController(vsync: this, duration: const Duration(seconds: 25))
      ..repeat(reverse: true);

    _anim1 = Tween<double>(begin: -100, end: 100).animate(
        CurvedAnimation(parent: _ctrl1, curve: Curves.easeInOut));
    _anim2 = Tween<double>(begin: -80, end: 120).animate(
        CurvedAnimation(parent: _ctrl2, curve: Curves.easeInOut));
    _anim3 = Tween<double>(begin: -120, end: 80).animate(
        CurvedAnimation(parent: _ctrl3, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl1.dispose();
    _ctrl2.dispose();
    _ctrl3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IgnorePointer(
      child: SizedBox.expand(
        child: Stack(
          children: [
            // Blob 1 (Purple)
            AnimatedBuilder(
              animation: _anim1,
              builder: (_, __) => Positioned(
                top: size.height * 0.1 + _anim1.value,
                left: size.width * 0.05,
                child: _Blob(size: 600, color: AppColors.purple.withOpacity(0.08)),
              ),
            ),
            // Blob 2 (Pink)
            AnimatedBuilder(
              animation: _anim2,
              builder: (_, __) => Positioned(
                top: size.height * 0.4 + _anim2.value,
                right: size.width * 0.02,
                child: _Blob(size: 500, color: AppColors.pink.withOpacity(0.06)),
              ),
            ),
            // Blob 3 (Blue)
            AnimatedBuilder(
              animation: _anim3,
              builder: (_, __) => Positioned(
                bottom: size.height * 0.1 + _anim3.value,
                left: size.width * 0.2,
                child: _Blob(size: 700, color: AppColors.blue.withOpacity(0.07)),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;
  const _Blob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.responsivePadding(context) * 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0),
          ],
        ),
      ),
    );
  }
}
