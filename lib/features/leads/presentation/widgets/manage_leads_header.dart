import 'package:flutter/material.dart';

class ManageLeadsHeader extends StatelessWidget {
  const ManageLeadsHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          //left section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage Leads',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                Text(
                  'manage all your leads under a single screen',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          //right section
          Image.asset('assets/images/leads.png', height: 70),
        ],
      ),
    );
  }
}
