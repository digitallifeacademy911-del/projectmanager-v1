import 'package:flutter/material.dart';
import 'package:projectmanager/common/theme/pallette.dart'; // Using your palette

class FormSubmit extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading; // Added to handle Supabase request latency
  final Color? backgroundColor;

  const FormSubmit({
    super.key,
    required this.child,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // Disable button while loading or if onPressed is null
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: PalleteColor.backgroundColor,
          foregroundColor: PalleteColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : child,
      ),
    );
  }
}
