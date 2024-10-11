import 'package:flutter/material.dart';


class AddToCartButton extends StatefulWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onPressed;

  const AddToCartButton({
    Key? key,
    required this.isLoading,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make the button full-width
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed, // Disable when loading
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // Text color
          backgroundColor: widget.isLoading
              ? Colors.grey
              : Colors.green, // Button color, disabled when loading
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
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
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
