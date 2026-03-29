import 'package:flutter/material.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';

class LeadCard extends StatelessWidget {
  final Lead lead;
  const LeadCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(child: Text(lead.name[0].toUpperCase())),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lead.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(lead.phone, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Text(lead.status, style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
