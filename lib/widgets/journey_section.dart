import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_theme.dart';
import 'common_widgets.dart';

class JourneySection extends StatelessWidget {
  const JourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final padding = AppSizes.responsivePadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        children: [
          const SectionHeader(
            badge: '📖 My Story',
            title: 'Journey & Growth',
            subtitle: 'My career path, education, and professional milestones',
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: [
                    const _ExperienceCard(),
                    const SizedBox(height: 24),
                    const _BScCard(),
                    const SizedBox(height: 24),
                    const _CertificationsCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 12, child: _ExperienceCard()),
                    const SizedBox(width: 24),
                    const Expanded(
                      flex: 10,
                      child: Column(
                        children: [
                          _BScCard(),
                          const SizedBox(height: 24),
                          _CertificationsCard(),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard();

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _hovered = false;

  final responsibilities = const [
    'Architected and developed multiple Flutter applications from scratch',
    'Integrated complex REST APIs and real-time Firebase/Cloud databases',
    'Implemented advanced state management patterns (BLoC, Riverpod, Provider)',
    'Transformed Figma designs into pixel-perfect and highly responsive UI/UX',
    'Optimized application performance, rendering speeds, and bundle sizes by 40%',
    'Implemented clean architecture with modular feature-first folders for long-term scalability',
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.015 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.bgCard.withOpacity(0.6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _hovered
                  ? AppColors.purple.withOpacity(0.6)
                  : AppColors.purple.withOpacity(0.18),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.purple.withOpacity(0.12),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: AppColors.purplePinkGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: _hovered
                                ? [
                                    BoxShadow(
                                      color: AppColors.purple.withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [],
                          ),
                          child: const Icon(FontAwesomeIcons.briefcase,
                              color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Junior Flutter Developer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.green.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: AppColors.green.withOpacity(0.35)),
                                    ),
                                    child: const Text(
                                      'Current',
                                      style: TextStyle(
                                          color: AppColors.green,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  const Text(
                                    'Prime Tech Solution',
                                    style: TextStyle(
                                        color: AppColors.purpleLight,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '•',
                                    style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        fontSize: 14),
                                  ),
                                  const Text(
                                    '2023 – Present',
                                    style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Achievements in columns/rows
                    Row(
                      children: [
                        Expanded(
                          child: _AchievementTile(
                            icon: FontAwesomeIcons.bolt,
                            gradient: const LinearGradient(
                                colors: [AppColors.blue, AppColors.cyan]),
                            title: '10+ Apps Delivered',
                            subtitle: 'Production-ready apps',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _AchievementTile(
                            icon: FontAwesomeIcons.trophy,
                            gradient: AppColors.purplePinkGradient,
                            title: 'High Performance',
                            subtitle: 'Fluent UI systems',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'Key Responsibilities & Deliverables',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2),
                    ),
                    const SizedBox(height: 16),
                    ...responsibilities.map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 350),
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(top: 6, right: 14),
                              decoration: BoxDecoration(
                                gradient: _hovered
                                    ? AppColors.purplePinkGradient
                                    : LinearGradient(colors: [
                                        AppColors.purple.withOpacity(0.5),
                                        AppColors.pink.withOpacity(0.5)
                                      ]),
                                shape: BoxShape.circle,
                                boxShadow: _hovered
                                    ? [
                                        BoxShadow(
                                          color: AppColors.pink.withOpacity(0.6),
                                          blurRadius: 6,
                                        )
                                      ]
                                    : [],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                r,
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                    height: 1.55),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AchievementTile extends StatefulWidget {
  final IconData icon;
  final LinearGradient gradient;
  final String title;
  final String subtitle;

  const _AchievementTile({
    required this.icon,
    required this.gradient,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_AchievementTile> createState() => _AchievementTileState();
}

class _AchievementTileState extends State<_AchievementTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? Colors.white.withOpacity(0.15)
                  : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: widget.gradient.colors[0].withOpacity(0.4),
                            blurRadius: 8,
                          )
                        ]
                      : [],
                ),
                child: Icon(widget.icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BScCard extends StatefulWidget {
  const _BScCard();

  @override
  State<_BScCard> createState() => _BScCardState();
}

class _BScCardState extends State<_BScCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.015 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.bgCard.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovered
                  ? AppColors.blue.withOpacity(0.6)
                  : AppColors.blue.withOpacity(0.18),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.blue.withOpacity(0.12),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.blue, AppColors.cyan]),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: _hovered
                            ? [
                                BoxShadow(
                                  color: AppColors.blue.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: const Icon(FontAwesomeIcons.graduationCap,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'BSc Computer Science',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Bangladesh University',
                      style: TextStyle(
                          color: AppColors.cyan,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '2019 – 2023',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Focused on software engineering fundamentals, database systems, algorithms, and mobile app engineering.',
                      style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.55),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CertificationsCard extends StatefulWidget {
  const _CertificationsCard();

  @override
  State<_CertificationsCard> createState() => _CertificationsCardState();
}

class _CertificationsCardState extends State<_CertificationsCard> {
  bool _hovered = false;

  final certifications = const [
    'Flutter & Dart - Udemy Complete Bootcamp',
    'Firebase for Flutter - Cloud Integration',
    'Clean Architecture & BLoC Pattern',
    'UI/UX Design Essentials - Figma Certification',
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.015 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.bgCard.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovered
                  ? AppColors.orange.withOpacity(0.6)
                  : AppColors.orange.withOpacity(0.18),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.orange.withOpacity(0.12),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.orange, AppColors.red]),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: _hovered
                            ? [
                                BoxShadow(
                                  color: AppColors.orange.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: const Icon(FontAwesomeIcons.award,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Certifications & Badges',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ...certifications.map(
                      (cert) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [AppColors.orange, AppColors.red]),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: _hovered
                                    ? [
                                        BoxShadow(
                                          color: AppColors.orange.withOpacity(0.3),
                                          blurRadius: 6,
                                        )
                                      ]
                                    : [],
                              ),
                              child: const Icon(Icons.verified,
                                  color: Colors.white, size: 14),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                cert,
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
