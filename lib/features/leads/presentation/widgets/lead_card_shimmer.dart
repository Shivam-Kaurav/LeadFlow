import 'package:flutter/material.dart';

class LeadCardShimmer extends StatelessWidget {
  const LeadCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /// Avatar placeholder
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 12),

            /// Text placeholders
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12,
                    width: 120,
                    color: Colors.grey.shade800,
                  ),
                  const SizedBox(height: 8),
                  Container(height: 10, width: 80, color: Colors.grey.shade700),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
