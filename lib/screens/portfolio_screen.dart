import 'package:flutter/material.dart';
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
        duration: const Duration(milliseconds: 700),
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
                  onDownloadCV: () {},
                ),

                _Divider(),

                // Work
                Container(key: _workKey),
                const WorkSection(),

                _Divider(),

                // Skills
                Container(key: _skillsKey),
                const SkillsSection(),

                _Divider(),

                // Journey
                Container(key: _journeyKey),
                const JourneySection(),

                _Divider(),

                // Connect
                Container(key: _connectKey),
                const ConnectSection(),

                // Footer
                const PortfolioFooter(),
              ],
            ),
          ),

          // Floating Navbar - on top of everything
          PortfolioNavbar(
            scrollController: _scrollController,
            onNavTap: _scrollToSection,
          ),
        ],
      ),
    );
  }
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
    _ctrl1 = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);
    _ctrl2 = AnimationController(
        vsync: this, duration: const Duration(seconds: 8))
      ..repeat(reverse: true);
    _ctrl3 = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat(reverse: true);

    _anim1 = Tween<double>(begin: -20, end: 20).animate(
        CurvedAnimation(parent: _ctrl1, curve: Curves.easeInOut));
    _anim2 = Tween<double>(begin: -30, end: 15).animate(
        CurvedAnimation(parent: _ctrl2, curve: Curves.easeInOut));
    _anim3 = Tween<double>(begin: -15, end: 25).animate(
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
    return IgnorePointer(
      child: SizedBox.expand(
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _anim1,
              builder: (_, __) => Positioned(
                top: 50 + _anim1.value,
                left: MediaQuery.of(context).size.width * 0.2,
                child: _Blob(
                  size: 350,
                  color: AppColors.purple.withOpacity(0.12),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _anim2,
              builder: (_, __) => Positioned(
                top: 100 + _anim2.value,
                right: MediaQuery.of(context).size.width * 0.2,
                child: _Blob(
                  size: 300,
                  color: AppColors.pink.withOpacity(0.1),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _anim3,
              builder: (_, __) => Positioned(
                top: 300 + _anim3.value,
                left: MediaQuery.of(context).size.width * 0.4,
                child: _Blob(
                  size: 280,
                  color: AppColors.blue.withOpacity(0.07),
                ),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ColorFilter.mode(color, BlendMode.srcOver),
        child: Container(),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.responsivePadding(context),
      ),
      color: Colors.white.withOpacity(0.04),
    );
  }
}
