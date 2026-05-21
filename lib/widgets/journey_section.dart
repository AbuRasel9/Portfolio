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
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: [
                    _ExperienceCard(),
                    const SizedBox(height: 20),
                    _EducationCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _ExperienceCard()),
                    const SizedBox(width: 20),
                    Expanded(child: _EducationCard()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final responsibilities = const [
    'Architected and developed multiple Flutter applications from scratch',
    'Integrated complex APIs and real-time Firebase services',
    'Implemented advanced state management patterns (BLoC, Riverpod)',
    'Transformed Figma designs into pixel-perfect UI implementations',
    'Mentored junior developers and conducted code reviews',
    'Optimized app performance and reduced build times by 40%',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
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
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.purple.withOpacity(0.15), AppColors.bgCard],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.purple.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppColors.purplePinkGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(FontAwesomeIcons.briefcase,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(height: 24),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(100),
                      border:
                          Border.all(color: AppColors.green.withOpacity(0.4)),
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
              const SizedBox(height: 4),
              const Text(
                'Prime Tech Solution',
                style: TextStyle(
                    color: AppColors.purple,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              const Text(
                '2023 – Present',
                style:
                    TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Achievements
              Row(
                children: [
                  Expanded(
                    child: _AchievementTile(
                      icon: FontAwesomeIcons.bolt,
                      gradient: const LinearGradient(
                          colors: [AppColors.blue, AppColors.cyan]),
                      title: '10+ Apps Delivered',
                      subtitle: 'Production-ready applications',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AchievementTile(
                      icon: FontAwesomeIcons.trophy,
                      gradient: AppColors.purplePinkGradient,
                      title: 'Team Collaboration',
                      subtitle: 'Cross-functional teamwork',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                'Key Responsibilities',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...responsibilities.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 7, right: 12),
                        decoration: BoxDecoration(
                          gradient: AppColors.purplePinkGradient,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r,
                          style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.blue.withOpacity(0.15), AppColors.bgCard],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.blue.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.blue, AppColors.cyan]),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(FontAwesomeIcons.graduationCap,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(height: 20),
              const Text('BSc Computer Science',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Bangladesh University',
                  style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              const Text('2019 – 2023',
                  style: TextStyle(
                      color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 16),
              const Text(
                'Focused on software engineering fundamentals, algorithms, and mobile development.',
                style: TextStyle(
                    color: AppColors.textSecondary, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.orange.withOpacity(0.15), AppColors.bgCard],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.orange.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.orange, AppColors.red]),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(FontAwesomeIcons.award,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(height: 20),
              const Text('Certifications',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ...[
                'Flutter & Dart - Udemy',
                'Firebase for Flutter',
                'Clean Architecture - BLoC',
                'UI/UX Design - Figma',
              ].map(
                (cert) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [AppColors.orange, AppColors.red]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.verified,
                            color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 12),
                      Text(cert,
                          style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
