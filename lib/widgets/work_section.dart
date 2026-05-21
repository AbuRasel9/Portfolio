import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/app_theme.dart';
import 'common_widgets.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final padding = AppSizes.responsivePadding(context);

    final projects = [
      _ProjectData(
        title: 'RUPSE',
        subtitle: 'B2B Flight Booking Platform',
        description:
            'Enterprise-grade flight booking app with real-time search, advanced filtering, and seamless payment integration.',
        imageUrl:
            'https://images.unsplash.com/photo-1694878981905-b742a32f8121?w=600&q=80',
        gradient: const LinearGradient(colors: [AppColors.purple, AppColors.pink]),
        bgColors: [AppColors.purple.withOpacity(0.15), AppColors.bgCard],
        tags: ['Flutter', 'Firebase', 'BLoC', 'REST API'],
        tagColor: AppColors.purple,
        users: '5K+',
        rating: '4.8',
      ),
      _ProjectData(
        title: 'TRIPPER',
        subtitle: 'Travel & Tour Booking',
        description:
            'Complete travel companion with hotel bookings, tour packages, and smart itinerary planning.',
        imageUrl:
            'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600&q=80',
        gradient: const LinearGradient(colors: [AppColors.blue, AppColors.cyan]),
        bgColors: [AppColors.blue.withOpacity(0.15), AppColors.bgCard],
        tags: ['Flutter', 'Google Maps', 'Riverpod', 'Dio'],
        tagColor: AppColors.blue,
        users: '3K+',
        rating: '4.7',
      ),
      _ProjectData(
        title: 'BUY TICKET',
        subtitle: 'Event & Entertainment Booking',
        description:
            'Modern ticketing platform with seat selection, QR codes, and instant booking confirmation.',
        imageUrl:
            'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80',
        gradient: const LinearGradient(
            colors: [AppColors.green, Color(0xFF10B981)]),
        bgColors: [AppColors.green.withOpacity(0.15), AppColors.bgCard],
        tags: ['Flutter', 'Provider', 'Sqflite', 'QR Code'],
        tagColor: AppColors.green,
        users: '8K+',
        rating: '4.9',
      ),
      _ProjectData(
        title: 'ShopEase',
        subtitle: 'E-Commerce Marketplace',
        description:
            'Full-featured shopping app with product catalog, cart, orders, and secure payments.',
        imageUrl:
            'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600&q=80',
        gradient: const LinearGradient(
            colors: [AppColors.orange, AppColors.red]),
        bgColors: [AppColors.orange.withOpacity(0.15), AppColors.bgCard],
        tags: ['Flutter', 'Firebase', 'GetX', 'Stripe'],
        tagColor: AppColors.orange,
        users: '12K+',
        rating: '4.8',
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        children: [
          const SectionHeader(
            badge: '🚀 Portfolio',
            title: 'Featured Work',
            subtitle: 'Real-world projects that solve problems and delight users',
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 0.75 : 0.8,
            ),
            itemCount: projects.length,
            itemBuilder: (ctx, i) => _ProjectCard(project: projects[i]),
          ),
        ],
      ),
    );
  }
}

class _ProjectData {
  final String title, subtitle, description, imageUrl;
  final LinearGradient gradient;
  final List<Color> bgColors;
  final List<String> tags;
  final Color tagColor;
  final String users, rating;

  const _ProjectData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.gradient,
    required this.bgColors,
    required this.tags,
    required this.tagColor,
    required this.users,
    required this.rating,
  });
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.project.bgColors,
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _hovered
                ? Colors.white.withOpacity(0.2)
                : AppColors.borderLight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: _hovered ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 600),
                      child: CachedNetworkImage(
                        imageUrl: widget.project.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (ctx, url) => Container(
                          color: AppColors.bgCard2,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.purple,
                            ),
                          ),
                        ),
                        errorWidget: (ctx, url, e) => Container(
                          color: AppColors.bgCard2,
                          child: const Icon(Icons.image_not_supported,
                              color: AppColors.textMuted, size: 40),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.bgPrimary.withOpacity(0.5),
                            AppColors.bgPrimary,
                          ],
                        ),
                      ),
                    ),
                    // Stats overlay
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Row(
                        children: [
                          _StatBadge('⭐ ${widget.project.rating}'),
                          const SizedBox(width: 8),
                          _StatBadge('👥 ${widget.project.users}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.project.subtitle,
                        style: TextStyle(
                          color: widget.project.tagColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          widget.project.description,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.tags
                            .map((t) => TagChip(
                                label: t, color: widget.project.tagColor))
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _ActionButton(
                            icon: FontAwesomeIcons.github,
                            label: 'Code',
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          _ActionButton(
                            icon: FontAwesomeIcons.mobileScreen,
                            label: 'Demo',
                            onTap: () {},
                            isPrimary: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String text;
  const _StatBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        // backdropFilter: null,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: isPrimary ? AppColors.purplePinkGradient : null,
          color: isPrimary ? null : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: isPrimary ? null : Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 13),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
