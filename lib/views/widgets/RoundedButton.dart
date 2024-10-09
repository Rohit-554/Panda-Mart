import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/config/themes/app_theme.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton(
      {super.key,
      required this.textEditingController,
      required this.onPressed,
      required this.text,
      this.isLoading = false});

  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  final isLoading;
  final String text;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.navButtonsColor,
          // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16), // Text style
        ),
        child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                widget.text,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ),
    );
  }
}
