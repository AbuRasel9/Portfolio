import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_theme.dart';
import 'common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final padding = AppSizes.responsivePadding(context);

    final skillCards = [
      _SkillData(
        category: 'Languages',
        icon: FontAwesomeIcons.code,
        gradient: const LinearGradient(colors: [AppColors.purple, AppColors.pink]),
        skills: ['Dart', 'Python', 'Java'],
        borderColor: AppColors.purple.withOpacity(0.2),
        bgColors: [AppColors.purple.withOpacity(0.15), AppColors.bgCard],
        skillColor: AppColors.purple,
      ),
      _SkillData(
        category: 'Framework',
        icon: FontAwesomeIcons.bolt,
        gradient: const LinearGradient(
            colors: [AppColors.pink, Color(0xFFF43F5E)]),
        skills: ['Flutter', 'Material Design', 'Cupertino'],
        borderColor: AppColors.pink.withOpacity(0.2),
        bgColors: [AppColors.pink.withOpacity(0.15), AppColors.bgCard],
        skillColor: AppColors.pink,
      ),
      _SkillData(
        category: 'State Mgmt',
        icon: FontAwesomeIcons.cubesStacked,
        gradient: const LinearGradient(
            colors: [AppColors.blue, AppColors.cyan]),
        skills: ['Riverpod', 'BLoC', 'Provider', 'GetX'],
        borderColor: AppColors.blue.withOpacity(0.2),
        bgColors: [AppColors.blue.withOpacity(0.15), AppColors.bgCard],
        skillColor: AppColors.blue,
      ),
      _SkillData(
        category: 'Database',
        icon: FontAwesomeIcons.database,
        gradient: const LinearGradient(
            colors: [AppColors.green, Color(0xFF10B981)]),
        skills: ['Hive', 'Sqflite', 'SharedPreferences', 'ObjectBox'],
        borderColor: AppColors.green.withOpacity(0.2),
        bgColors: [AppColors.green.withOpacity(0.15), AppColors.bgCard],
        skillColor: AppColors.green,
      ),
      _SkillData(
        category: 'Backend & API',
        icon: FontAwesomeIcons.rocket,
        gradient: const LinearGradient(
            colors: [AppColors.orange, AppColors.red]),
        skills: ['Firebase', 'REST API', 'Dio', 'GraphQL'],
        borderColor: AppColors.orange.withOpacity(0.2),
        bgColors: [AppColors.orange.withOpacity(0.15), AppColors.bgCard],
        skillColor: AppColors.orange,
      ),
      _SkillData(
        category: 'Design',
        icon: FontAwesomeIcons.paintbrush,
        gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), AppColors.purple]),
        skills: ['Figma', 'Adobe XD', 'UI/UX', 'Animations'],
        borderColor: const Color(0xFF8B5CF6).withOpacity(0.2),
        bgColors: [const Color(0xFF8B5CF6).withOpacity(0.15), AppColors.bgCard],
        skillColor: const Color(0xFF8B5CF6),
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        children: [
          const SectionHeader(
            badge: '⚡ My Arsenal',
            title: 'Skills & Tools',
            subtitle: 'Technologies I use to bring ideas to life',
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (AppSizes.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 2.2 : 1.2,
            ),
            itemCount: skillCards.length,
            itemBuilder: (ctx, i) => _SkillCard(data: skillCards[i]),
          ),
        ],
      ),
    );
  }
}

class _SkillData {
  final String category;
  final IconData icon;
  final LinearGradient gradient;
  final List<String> skills;
  final Color borderColor;
  final List<Color> bgColors;
  final Color skillColor;

  const _SkillData({
    required this.category,
    required this.icon,
    required this.gradient,
    required this.skills,
    required this.borderColor,
    required this.bgColors,
    required this.skillColor,
  });
}

class _SkillCard extends StatefulWidget {
  final _SkillData data;
  const _SkillCard({required this.data});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.data.bgColors,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? widget.data.borderColor.withOpacity(0.6)
                : widget.data.borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: widget.data.gradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(widget.data.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.data.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.data.skills
                  .map((s) => TagChip(label: s, color: widget.data.skillColor))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
