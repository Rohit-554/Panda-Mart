import 'package:flutter/material.dart';

import '../../viewmodel/auth_viewmodel.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.authViewModel,
  });

  final AuthViewModel authViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.red[50],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  authViewModel.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  authViewModel.setErrorMessage(null); // Clear the error message
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}