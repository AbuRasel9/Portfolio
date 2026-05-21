import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    const SizedBox(height: 20),
                    _ContactInfo(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 3, child: _ContactForm()),
                    const SizedBox(width: 20),
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

  void _handleSubmit() {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _msgCtrl.text.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Thanks for reaching out! I'll get back to you soon."),
        backgroundColor: AppColors.purple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
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
    return Container(
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
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.purplePinkGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(FontAwesomeIcons.commentDots,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              const Text(
                'Send me a message',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Name & Email row
          LayoutBuilder(builder: (ctx, constraints) {
            if (constraints.maxWidth > 400) {
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
            hint: 'Tell me about your project...',
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          _SubmitButton(onTap: _handleSubmit),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: inputType,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(color: AppColors.textMuted, fontSize: 14),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
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
                  BorderSide(color: AppColors.purple.withOpacity(0.5), width: 2),
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
                  color: AppColors.purple.withOpacity(0.3),
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
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
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

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contacts = [
      _ContactItem(
        icon: Icons.email_rounded,
        label: 'Email',
        value: 'aburasel@example.com',
        color: AppColors.purple,
      ),
      _ContactItem(
        icon: Icons.phone_rounded,
        label: 'Phone',
        value: '+880 1234-567890',
        color: AppColors.blue,
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
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.pink.withOpacity(0.15), AppColors.bgCard],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.pink.withOpacity(0.2)),
          ),
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
                    child: Row(
                      children: [
                        Container(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.label,
                                style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 11)),
                            Text(c.value,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  )),
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
              colors: [AppColors.blue.withOpacity(0.15), AppColors.bgCard],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.blue.withOpacity(0.2)),
          ),
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
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _SocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    gradient: const LinearGradient(
                        colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)]),
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _SocialButton(
                    icon: Icons.email_rounded,
                    gradient: AppColors.purplePinkGradient,
                    onTap: () {},
                  ),
                ],
              ),
            ],
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
  const _ContactItem(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});
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
          scale: _hovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(widget.icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}
