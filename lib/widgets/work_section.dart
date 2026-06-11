import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
        title: 'Flights Nepal',
        subtitle: 'Travel Platform',
        description:
            'A premier flight booking application in Nepal, delivering domestic and international ticket bookings with secure payments.',
        imageUrl:
            'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=600&q=80',
        gradient: const LinearGradient(colors: [AppColors.purple, AppColors.pink]),
        bgColors: [AppColors.purple.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Firebase', 'REST API'],
        tagColor: AppColors.purple,
        users: '50K+',
        rating: '4.9',
        githubUrl: 'https://github.com/AbuRasel9',
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ptsl.flightsnepal',
      ),
      _ProjectData(
        title: 'Tripper',
        subtitle: 'Tour Guide',
        description:
            'Complete travel ecosystem with hotel booking interfaces and dynamic travel itinerary planning tools.',
        imageUrl:
            'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600&q=80',
        gradient: const LinearGradient(colors: [AppColors.blue, AppColors.cyan]),
        bgColors: [AppColors.blue.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Google Maps', 'Dio'],
        tagColor: AppColors.blue,
        users: '10K+',
        rating: '4.8',
        githubUrl: 'https://github.com/AbuRasel9',
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ptsl.flightsnepal',
      ),
      _ProjectData(
        title: 'Buy Ticket',
        subtitle: 'Event Reservation',
        description:
            'High-end ticketing platform facilitating digital seat selection and personalized QR ticket codes.',
        imageUrl:
            'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80',
        gradient: const LinearGradient(colors: [AppColors.green, Color(0xFF059669)]),
        bgColors: [AppColors.green.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Provider', 'QR Code'],
        tagColor: AppColors.green,
        users: '8K+',
        rating: '4.9',
        githubUrl: 'https://github.com/AbuRasel9',
      ),
      _ProjectData(
        title: 'ShopEase',
        subtitle: 'Marketplace',
        description:
            'Full-scale shopping platform featuring search-by-image and secure checkout portals.',
        imageUrl:
            'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600&q=80',
        gradient: const LinearGradient(colors: [AppColors.orange, AppColors.red]),
        bgColors: [AppColors.orange.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'GetX', 'Stripe'],
        tagColor: AppColors.orange,
        users: '15K+',
        rating: '4.8',
        githubUrl: 'https://github.com/AbuRasel9',
      ),
    ];

    final isTablet = AppSizes.isTablet(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        children: [
          const SectionHeader(
            badge: 'Project',
            title: 'Featured Work',
            subtitle: 'Crafting digital experiences with precision',
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.1 : (isTablet ? 0.95 : 0.88),
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
  final String? githubUrl;
  final String? playStoreUrl;

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
    this.githubUrl,
    this.playStoreUrl,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _hovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? widget.project.tagColor.withValues(alpha: 0.4)
                : AppColors.borderLight,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? widget.project.tagColor.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: _hovered ? 20 : 10,
              offset: Offset(0, _hovered ? 10 : 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgCard.withValues(alpha: 0.7),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Expanded(
                    flex: 5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.project.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (ctx, url) => Container(color: AppColors.bgCard2),
                          errorWidget: (ctx, url, e) => const Icon(Icons.image_not_supported),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 12,
                        //   left: 12,
                        //   right: 12,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       _StatBadge(
                        //         icon: Icons.star_rounded,
                        //         text: widget.project.rating,
                        //         color: Colors.amber,
                        //       ),
                        //       _StatBadge(
                        //         icon: Icons.group_rounded,
                        //         text: widget.project.users,
                        //         color: Colors.white,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.project.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.arrowUpRightFromSquare,
                                color: widget.project.tagColor.withValues(alpha: 0.6),
                                size: 12,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.project.subtitle,
                            style: TextStyle(
                              color: widget.project.tagColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              widget.project.description,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 11,
                                height: 1.4,
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
                                .map((t) => _SmallTag(label: t, color: widget.project.tagColor))
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (widget.project.githubUrl != null)
                                _CompactIconButton(
                                  icon: FontAwesomeIcons.github,
                                  onTap: () => _launch(widget.project.githubUrl!),
                                ),
                              const SizedBox(width: 8),
                              if (widget.project.playStoreUrl != null)
                                Expanded(
                                  child: _CompactPrimaryButton(
                                    label: 'Live Demo',
                                    color: widget.project.tagColor,
                                    onTap: () => _launch(widget.project.playStoreUrl!),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _StatBadge({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  final String label;
  final Color color;

  const _SmallTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _CompactIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CompactIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderLight),
          color: Colors.white.withValues(alpha: 0.05),
        ),
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }
}

class _CompactPrimaryButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CompactPrimaryButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.8)]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
