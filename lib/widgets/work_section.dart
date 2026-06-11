import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import '../models/app_theme.dart';
import 'common_widgets.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.responsivePadding(context);

    final projects = [
      _ProjectData(
        title: 'Flights Nepal',
        subtitle: 'B2B & B2C Flight Booking App',
        description:
            'A high-performance, cross-platform flight booking application serving 50K+ active users in Nepal. Features real-time ticketing, domestic/international routing, and secure local gateway integrations.',
        features: [
          'Developed a fully responsive flight search, seat selection, and ticketing system.',
          'Integrated secure local/international payment gateways for seamless transactions.',
          'Optimized network state transitions and API request lifecycles to minimize data usage.'
        ],
        imagePath: 'assets/images/flights_nepal_web_logo.png',
        isAsset: true,
        gradient: const LinearGradient(colors: [AppColors.purple, AppColors.pink]),
        bgColors: [AppColors.purple.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Firebase', 'REST APIs', 'Payment Gateway'],
        tagColor: AppColors.purple,
        users: '50K+ Users',
        rating: '4.9 Star Rating',
        githubUrl: 'https://github.com/AbuRasel9',
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ptsl.flightsnepal',
      ),
      _ProjectData(
        title: 'Rupse Flights',
        subtitle: 'Enterprise B2B Flight Agent System',
        description:
            'A dedicated B2B travel agency booking engine optimized for sub-agent networks. Built with offline availability in mind, helping agents issue tickets instantly in remote areas.',
        features: [
          'Implemented highly robust offline database caching using Hive for search histories and ticket logs.',
          'Built complex state management flows using Riverpod to track sub-agent balances and commissions.',
          'Designed high-density, screen-adaptive dashboards catering to tablet and web environments.'
        ],
        imagePath: 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=600&q=80',
        isAsset: false,
        gradient: const LinearGradient(colors: [AppColors.blue, AppColors.cyan]),
        bgColors: [AppColors.blue.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Riverpod', 'Hive DB', 'Clean Architecture'],
        tagColor: AppColors.blue,
        users: 'Agent Network',
        rating: '4.8 Star Rating',
        githubUrl: 'https://github.com/AbuRasel9',
      ),
      _ProjectData(
        title: 'Tripper',
        subtitle: 'B2B & B2C Travel Booking App',
        description:
            'A comprehensive travel booking suite offering customized packages, real-time hotel stays, and visa application trackers. Seamlessly connects end-consumers with local agency back-offices.',
        features: [
          'Integrated Google Maps API for geolocation-based hotel discovery and visual route planners.',
          'Developed a dynamic vacation package builder supporting multi-city stay configurations.',
          'Utilized Provider state syncing with a Firebase database to deliver instant transaction alerts.'
        ],
        imagePath: 'assets/images/tripper_icon.png',
        isAsset: true,
        gradient: const LinearGradient(colors: [AppColors.orange, AppColors.red]),
        bgColors: [AppColors.orange.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Provider', 'Firebase', 'Google Maps'],
        tagColor: AppColors.orange,
        users: '10K+ Users',
        rating: '4.8 Star Rating',
        githubUrl: 'https://github.com/AbuRasel9',
      ),
      _ProjectData(
        title: 'Buy Ticket',
        subtitle: 'B2B & B2C Ticket Booking App',
        description:
            'A digital event and transport ticket booking engine in Bangladesh. Offers interactive layouts for ticket purchases with secure automated entry passes.',
        features: [
          'Designed and engineered a custom, dynamic seat layout grid using vector SVG paths.',
          'Developed local cryptographic ticketing modules that generate scannable offline QR validation codes.',
          'Leveraged GetX and Provider state management to optimize resource usage on entry-level phones.'
        ],
        imagePath: 'assets/images/buytickets_logo.png',
        isAsset: true,
        gradient: const LinearGradient(colors: [AppColors.green, Color(0xFF059669)]),
        bgColors: [AppColors.green.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'GetX', 'Provider', 'QR Integration'],
        tagColor: AppColors.green,
        users: '8K+ Users',
        rating: '4.9 Star Rating',
        githubUrl: 'https://github.com/AbuRasel9',
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.buytickets.bd',
      ),
      _ProjectData(
        title: 'Mess Manager',
        subtitle: 'Bachelor Mess Utility Ledger',
        description:
            'A localized accounting tool designed for shared household cost-splitting. Handles meal trackers, grocery ledgers, and cash balances to automate end-of-month cost distribution.',
        features: [
          'Built an automated expense-matching algorithm to calculate dues and minimize cash transfers.',
          'Integrated secure local storage via Hive DB, delivering zero-latency offline data access.',
          'Designed a minimalist, highly actionable dark-mode dashboard for mobile screen profiles.'
        ],
        imagePath: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&q=80',
        isAsset: false,
        gradient: const LinearGradient(colors: [AppColors.pink, AppColors.purpleLight]),
        bgColors: [AppColors.pink.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'Hive DB', 'Expense Split', 'Local First'],
        tagColor: AppColors.pink,
        users: 'Personal Project',
        rating: '4.7 Star Rating',
        githubUrl: 'https://github.com/AbuRasel9',
      ),
      _ProjectData(
        title: 'ShopEase E-Commerce',
        subtitle: 'REST-API Powered Marketplace',
        description:
            'A premium online retail store featuring complete shopping card cycles, search filters, and profile controls. Deployed on clean code practices for modular scaling.',
        features: [
          'Implemented OAuth2 authentication workflows with Dio request/response interceptors.',
          'Optimized memory usage in list-scrolling by incorporating cached image layers and layout constraints.',
          'Leveraged Provider state architecture to bind the product catalogs, active cart, and order list.'
        ],
        imagePath: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=600&q=80',
        isAsset: false,
        gradient: const LinearGradient(colors: [AppColors.blue, AppColors.purple]),
        bgColors: [AppColors.blue.withValues(alpha: 0.08), AppColors.bgCard],
        tags: ['Flutter', 'REST APIs', 'OAuth2', 'Provider'],
        tagColor: AppColors.blue,
        users: 'Open Source',
        rating: '4.8 Star Rating',
        githubUrl: 'https://github.com/AbuRasel9/Ecommerce-App',
      ),
    ];

    final isDesktop = AppSizes.isDesktop(context);

    if (isDesktop) {
      final rowsCount = (projects.length / 2).ceil();
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
            Column(
              children: List.generate(rowsCount, (rowIndex) {
                final firstIndex = rowIndex * 2;
                final secondIndex = firstIndex + 1;
                final hasSecond = secondIndex < projects.length;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 600),
                            delay: Duration(milliseconds: firstIndex * 80),
                            child: _ProjectCard(
                              project: projects[firstIndex],
                              index: firstIndex,
                              isTwoColumn: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: hasSecond
                              ? FadeInUp(
                                  duration: const Duration(milliseconds: 600),
                                  delay: Duration(milliseconds: secondIndex * 80),
                                  child: _ProjectCard(
                                    project: projects[secondIndex],
                                    index: secondIndex,
                                    isTwoColumn: true,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    } else {
      // Tablet and Mobile: 1 column
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
            Column(
              children: List.generate(
                projects.length,
                (i) => FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: i * 80),
                  child: _ProjectCard(
                    project: projects[i],
                    index: i,
                    isTwoColumn: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _ProjectData {
  final String title, subtitle, description, imagePath;
  final List<String> features;
  final bool isAsset;
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
    required this.features,
    required this.imagePath,
    this.isAsset = false,
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
  final int index;
  final bool isTwoColumn;
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.isTwoColumn,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isImageLeft = widget.index % 2 == 0;
    final screenWidth = MediaQuery.of(context).size.width;

    // Use vertical layout on mobile and on narrower desktops where 2-column makes cards tight
    final bool useVertical;
    if (screenWidth < 768) {
      useVertical = true;
    } else if (widget.isTwoColumn && screenWidth < 1280) {
      useVertical = true;
    } else {
      useVertical = false;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: widget.isTwoColumn ? 0 : 48),
        transform: Matrix4.translationValues(0.0, _hovered ? -8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: AppColors.bgCard.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? widget.project.tagColor.withValues(alpha: 0.5)
                : AppColors.borderLight,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? widget.project.tagColor.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: _hovered ? 30 : 15,
              offset: Offset(0, _hovered ? 12 : 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: useVertical
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImageSection(context, true),
                    _buildDetailsSection(context, true),
                  ],
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: isImageLeft
                        ? [
                            Expanded(flex: 5, child: _buildImageSection(context, false)),
                            Expanded(flex: 7, child: _buildDetailsSection(context, false)),
                          ]
                        : [
                            Expanded(flex: 7, child: _buildDetailsSection(context, false)),
                            Expanded(flex: 5, child: _buildImageSection(context, false)),
                          ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, bool isVertical) {
    final project = widget.project;

    Widget imgWidget = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: project.isAsset
          ? Padding(
              padding: EdgeInsets.all(isVertical ? 12 : (widget.isTwoColumn ? 12 : 16)),
              child: Image.asset(
                project.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.bgCard2,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.white24, size: 24),
                    ),
                  );
                },
              ),
            )
          : CachedNetworkImage(
              imageUrl: project.imagePath,
              fit: BoxFit.cover,
              placeholder: (ctx, url) => Container(color: AppColors.bgCard2),
              errorWidget: (ctx, url, e) => const Center(
                child: Icon(Icons.image_not_supported, color: Colors.white24, size: 24),
              ),
            ),
    );

    final double size = isVertical ? 120.0 : (widget.isTwoColumn ? 120.0 : 160.0);

    return Container(
      height: isVertical ? 180 : double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            project.gradient.colors[0].withValues(alpha: 0.08),
            project.gradient.colors[1].withValues(alpha: 0.01),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: AnimatedScale(
          scale: _hovered ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.bgCard2,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _hovered
                    ? project.tagColor.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _hovered
                      ? project.tagColor.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.3),
                  blurRadius: _hovered ? 25 : 12,
                  offset: Offset(0, _hovered ? 8 : 4),
                ),
              ],
            ),
            child: imgWidget,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context, bool isVertical) {
    final project = widget.project;
    final isCompact = widget.isTwoColumn || isVertical;

    return Padding(
      padding: EdgeInsets.all(isVertical ? 20 : (isCompact ? 24 : 36)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Subtitle
          Text(
            project.subtitle.toUpperCase(),
            style: TextStyle(
              color: project.tagColor,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),

          // Title
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isVertical ? 22 : (isCompact ? 20 : 28),
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: _hovered ? 0.125 : 0,
                child: Icon(
                  FontAwesomeIcons.arrowUpRightFromSquare,
                  color: project.tagColor.withValues(alpha: 0.8),
                  size: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Stat Badges
          Row(
            children: [
              _StatBadge(
                icon: Icons.star_rounded,
                text: project.rating,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              _StatBadge(
                icon: Icons.group_rounded,
                text: project.users,
                color: Colors.white70,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description Text
          Text(
            project.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),

          // Key Highlights from CV
          ...project.features.map(
            (feat) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.5),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: project.tagColor,
                      size: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feat,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tech Chips Wrap
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.tags
                .map((t) => _SmallTag(label: t, color: project.tagColor))
                .toList(),
          ),
          const SizedBox(height: 24),

          // Action Buttons Row
          Row(
            children: [
              if (project.githubUrl != null)
                _CompactIconButton(
                  icon: FontAwesomeIcons.github,
                  onTap: () => _launch(project.githubUrl!),
                ),
              if (project.githubUrl != null) const SizedBox(width: 10),
              if (project.playStoreUrl != null)
                Expanded(
                  child: _CompactPrimaryButton(
                    label: 'View on Play Store',
                    color: project.tagColor,
                    onTap: () => _launch(project.playStoreUrl!),
                  ),
                )
              else if (project.githubUrl != null)
                Expanded(
                  child: _CompactPrimaryButton(
                    label: 'View Repository',
                    color: project.tagColor,
                    onTap: () => _launch(project.githubUrl!),
                  ),
                ),
            ],
          ),
        ],
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderLight),
            color: Colors.white.withValues(alpha: 0.05),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


