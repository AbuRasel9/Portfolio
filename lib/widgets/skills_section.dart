import 'dart:ui';
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
      const _SkillData(
        category: 'Mobile Dev',
        icon: Icons.phone_android_rounded,
        gradient: LinearGradient(colors: [Color(0xFF6366F1), Color(0xFFA855F7)]),
        skills: ['Flutter', 'Dart', 'Android/iOS', 'App Store',],
        skillColor: Color(0xFF818CF8),
      ),
      const _SkillData(
        category: 'State Management',
        icon: FontAwesomeIcons.brain,
        gradient: LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)]),
        skills: ['Riverpod', 'BLoC', 'Provider', 'GetX'],
        skillColor: Color(0xFF60A5FA),
      ),
      const _SkillData(
        category: 'Backend & DB',
        icon: FontAwesomeIcons.server,
        gradient: LinearGradient(colors: [Color(0xFF10B981), Color(0xFF3B82F6)]),
        skills: ['Firebase', 'Supabase', 'Hive', ],
        skillColor: Color(0xFF34D399),
      ),
      const _SkillData(
        category: 'Tools & Design',
        icon: FontAwesomeIcons.penNib,
        gradient: LinearGradient(colors: [Color(0xFFF43F5E), Color(0xFFFB923C)]),
        skills: ['Figma', 'Git', 'CI/CD', 'Adobe XD'],
        skillColor: Color(0xFFFB7185),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      child: Column(
        children: [
          const SectionHeader(
            badge: 'Skills & Tools',
            // title: 'Skills & Tools',
            // subtitle: 'Crafting excellence with the modern tech stack',
          ),
          const SizedBox(height: 20),
          // Unique Layout: Use a custom wrap or grid that looks less "standard"
          LayoutBuilder(builder: (context, constraints) {
            return Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: skillCards.map((card) => SizedBox(
                width: isMobile ? constraints.maxWidth : (constraints.maxWidth - 48) / 2,
                child: _EnhancedSkillCard(data: card),
              )).toList(),
            );
          }),
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
  final Color skillColor;

  const _SkillData({
    required this.category,
    required this.icon,
    required this.gradient,
    required this.skills,
    required this.skillColor,
  });
}

class _EnhancedSkillCard extends StatefulWidget {
  final _SkillData data;
  const _EnhancedSkillCard({required this.data});

  @override
  State<_EnhancedSkillCard> createState() => _EnhancedSkillCardState();
}

class _EnhancedSkillCardState extends State<_EnhancedSkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: _isHovered ? widget.data.skillColor.withOpacity(0.4) : AppColors.borderLight,
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // Glowing background effect
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                top: _isHovered ? -50 : -100,
                right: _isHovered ? -50 : -100,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.data.skillColor.withOpacity(_isHovered ? 0.15 : 0.05),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: widget.data.gradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: widget.data.skillColor.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: Icon(widget.data.icon, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.category,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 2,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: widget.data.skillColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: widget.data.skills.map((skill) {
                        return _ModernSkillBadge(
                          label: skill,
                          color: widget.data.skillColor,
                          isHovered: _isHovered,
                        );
                      }).toList(),
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

class _ModernSkillBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isHovered;

  const _ModernSkillBadge({
    required this.label,
    required this.color,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isHovered ? color.withOpacity(0.15) : Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHovered ? color.withOpacity(0.3) : Colors.white.withOpacity(0.08),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isHovered ? Colors.white : Colors.white.withOpacity(0.7),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
