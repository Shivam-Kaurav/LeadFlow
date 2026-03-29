import 'package:flutter/material.dart';
import 'package:leadflow/features/leads/domain/entities/lead_entity.dart';
import 'package:leadflow/features/leads/presentation/widgets/lead_card.dart';
import 'package:leadflow/features/leads/presentation/widgets/lead_search_bar.dart';
import 'package:leadflow/features/leads/presentation/widgets/leads_filter_tabs.dart';
import 'package:leadflow/features/leads/presentation/widgets/manage_leads_header.dart';

class ManageLeadsScreen extends StatefulWidget {
  const ManageLeadsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ManageLeadsScreenState();
}

class _ManageLeadsScreenState extends State<ManageLeadsScreen> {
  String selectedFilter = 'All';
  List<Lead> allLeads = [
    Lead(id: '1', name: 'Shivam', phone: '9999999999', status: 'Fresh'),
    Lead(id: '2', name: 'Rahul', phone: '8888888888', status: 'Pending'),
    Lead(id: '3', name: 'Amit', phone: '7777777777', status: 'Meeting'),
  ];

  List<Lead> get filteredLeads {
    if (selectedFilter == 'All') return allLeads;
    return allLeads.where((e) => e.status == selectedFilter).toList();
  }

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
        title: Text(
          'Hi Shivam',
          style: Theme.of(context).textTheme.titleMedium,
        ),

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
            const SizedBox(height: 10),
            LeadsFilterTabs(
              filters: const [
                'All',
                'Fresh',
                'Pending',
                'Meeting',
                'Site Visit',
              ],
              selected: selectedFilter,
              onSelected: (value) {
                setState(() {
                  selectedFilter = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLeads.length,
                itemBuilder: (context, index) {
                  return LeadCard(lead: filteredLeads[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
