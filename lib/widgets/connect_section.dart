import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_theme.dart';
import 'common_widgets.dart';

class ConnectSection extends StatelessWidget {
  const ConnectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final padding = AppSizes.responsivePadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 80),
      child: Column(
        children: [
          const SectionHeader(
            badge: '💬 Let\'s Connect',
            title: 'Start a Project',
            subtitle: 'Got an idea? Let\'s turn it into reality together',
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: [
                    const _ContactForm(),
                    const SizedBox(height: 24),
                    _ContactInfo(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 3, child: _ContactForm()),
                    const SizedBox(width: 24),
                    Expanded(flex: 2, child: _ContactInfo()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _formHovered = false;

  Future<void> _handleSubmit() async {
    if (_nameCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        _msgCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please fill in all fields before sending."),
          backgroundColor: AppColors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final subject = Uri.encodeComponent('Project Inquiry from ${_nameCtrl.text}');
    final body = Uri.encodeComponent(
      'Hi Abu Rasel,\n\n'
      'I am reaching out regarding a new project opportunity:\n\n'
      '${_msgCtrl.text}\n\n'
      'Please get back to me at: ${_emailCtrl.text}\n\n'
      'Best regards,\n'
      '${_nameCtrl.text}'
    );
    
    final mailtoUrl = 'mailto:aburasel.ptsl@gmail.com?subject=$subject&body=$body';
    final uri = Uri.parse(mailtoUrl);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Opening your email client..."),
        backgroundColor: AppColors.purple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Could not open email client. Please email directly to aburasel.ptsl@gmail.com"),
          backgroundColor: AppColors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    _nameCtrl.clear();
    _emailCtrl.clear();
    _msgCtrl.clear();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _formHovered = true),
      onExit: (_) => setState(() => _formHovered = false),
      child: AnimatedScale(
        scale: _formHovered ? 1.008 : 1.0,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: AppColors.bgCard.withOpacity(0.6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _formHovered
                  ? AppColors.purple.withOpacity(0.5)
                  : AppColors.purple.withOpacity(0.18),
              width: 1.5,
            ),
            boxShadow: _formHovered
                ? [
                    BoxShadow(
                      color: AppColors.purple.withOpacity(0.1),
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
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: AppColors.purplePinkGradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: _formHovered
                                ? [
                                    BoxShadow(
                                      color: AppColors.purple.withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    )
                                  ]
                                : [],
                          ),
                          child: const Icon(FontAwesomeIcons.commentDots,
                              color: Colors.white, size: 20),
                        ),
                        const Expanded(
                          child: Text(
                            'Send me a message',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Name & Email row
                    LayoutBuilder(builder: (ctx, constraints) {
                      if (constraints.maxWidth > 500) {
                        return Row(
                          children: [
                            Expanded(child: _InputField(controller: _nameCtrl, label: 'Your Name', hint: 'John Doe')),
                            const SizedBox(width: 16),
                            Expanded(child: _InputField(controller: _emailCtrl, label: 'Email Address', hint: 'john@example.com', inputType: TextInputType.emailAddress)),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          _InputField(controller: _nameCtrl, label: 'Your Name', hint: 'John Doe'),
                          const SizedBox(height: 16),
                          _InputField(controller: _emailCtrl, label: 'Email Address', hint: 'john@example.com', inputType: TextInputType.emailAddress),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    _InputField(
                      controller: _msgCtrl,
                      label: 'Project Details',
                      hint: 'Tell me about your project or app idea...',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 28),
                    _SubmitButton(onTap: _handleSubmit),
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

class _InputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType inputType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.purple.withOpacity(0.12),
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            maxLines: widget.maxLines,
            keyboardType: widget.inputType,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:
                  const TextStyle(color: AppColors.textMuted, fontSize: 14),
              filled: true,
              fillColor: _isFocused
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.05),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppColors.purple, width: 1.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SubmitButton({required this.onTap});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: AppColors.purplePinkGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.purple.withOpacity(_hovered ? 0.45 : 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Send Message',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5),
                ),
                SizedBox(width: 8),
                Icon(Icons.send_rounded, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatefulWidget {
  @override
  State<_ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<_ContactInfo> {
  bool _infoHovered = false;
  bool _socialHovered = false;

  Future<void> _launchURL(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contacts = [
      _ContactItem(
        icon: Icons.email_rounded,
        label: 'Email',
        value: 'aburasel.ptsl@gmail.com',
        color: AppColors.purple,
        onTap: () => _launchURL('mailto:aburasel.ptsl@gmail.com?subject=Project Inquiry'),
      ),
      _ContactItem(
        icon: Icons.phone_rounded,
        label: 'Phone',
        value: '+880 1782-536399',
        color: AppColors.blue,
        onTap: () => _launchURL('tel:+8801782536399'),
      ),
      _ContactItem(
        icon: Icons.location_on_rounded,
        label: 'Location',
        value: 'Dhaka, Bangladesh',
        color: AppColors.green,
      ),
    ];

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _infoHovered = true),
          onExit: (_) => setState(() => _infoHovered = false),
          child: AnimatedScale(
            scale: _infoHovered ? 1.015 : 1.0,
            duration: const Duration(milliseconds: 250),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.bgCard.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _infoHovered
                      ? AppColors.pink.withOpacity(0.5)
                      : AppColors.pink.withOpacity(0.18),
                  width: 1.5,
                ),
                boxShadow: _infoHovered
                    ? [
                        BoxShadow(
                          color: AppColors.pink.withOpacity(0.1),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Contact Info',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      ...contacts.map((c) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: InkWell(
                              onTap: c.onTap,
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: c.color.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: c.color.withOpacity(0.3)),
                                      ),
                                      child: Icon(c.icon, color: c.color, size: 20),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(c.label,
                                              style: const TextStyle(
                                                  color: AppColors.textMuted,
                                                  fontSize: 11)),
                                          const SizedBox(height: 2),
                                          Text(c.value,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        MouseRegion(
          onEnter: (_) => setState(() => _socialHovered = true),
          onExit: (_) => setState(() => _socialHovered = false),
          child: AnimatedScale(
            scale: _socialHovered ? 1.015 : 1.0,
            duration: const Duration(milliseconds: 250),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.bgCard.withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _socialHovered
                      ? AppColors.blue.withOpacity(0.5)
                      : AppColors.blue.withOpacity(0.18),
                  width: 1.5,
                ),
                boxShadow: _socialHovered
                    ? [
                        BoxShadow(
                          color: AppColors.blue.withOpacity(0.1),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Find Me On',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _SocialButton(
                            icon: FontAwesomeIcons.github,
                            gradient: const LinearGradient(
                                colors: [Color(0xFF374151), Color(0xFF4B5563)]),
                            onTap: () => _launchURL('https://github.com/AbuRasel9'),
                          ),
                          const SizedBox(width: 12),
                          _SocialButton(
                            icon: FontAwesomeIcons.linkedin,
                            gradient: const LinearGradient(
                                colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)]),
                            onTap: () => _launchURL('https://www.linkedin.com/in/abu-rasel-76b3b5220'),
                          ),
                          const SizedBox(width: 12),
                          _SocialButton(
                            icon: Icons.email_rounded,
                            gradient: AppColors.purplePinkGradient,
                            onTap: () => _launchURL('mailto:aburasel.ptsl@gmail.com?subject=Project Inquiry'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactItem {
  final IconData icon;
  final String label, value;
  final Color color;
  final VoidCallback? onTap;
  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.onTap,
  });
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final LinearGradient gradient;
  final VoidCallback onTap;
  const _SocialButton(
      {required this.icon, required this.gradient, required this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.15 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: widget.gradient.colors[0].withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: Icon(widget.icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
