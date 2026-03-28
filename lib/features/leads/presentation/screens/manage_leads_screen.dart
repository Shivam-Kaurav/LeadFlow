import 'package:flutter/material.dart';
import 'package:leadflow/features/leads/presentation/widgets/lead_search_bar.dart';
import 'package:leadflow/features/leads/presentation/widgets/manage_leads_header.dart';

class ManageLeadsScreen extends StatefulWidget {
  const ManageLeadsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ManageLeadsScreenState();
}

class _ManageLeadsScreenState extends State<ManageLeadsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle_outlined),
        title: const Text('Hi Shivam'),

        actions: const [
          Icon(Icons.call),
          SizedBox(width: 12),
          Icon(Icons.notifications),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ManageLeadsHeader(),
            const SizedBox(height: 10),
            LeadSearchBar(
              controller: _searchController,
              onFilterTap: () {},
              onSearchChanged: (value) {},
              onSavedTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
