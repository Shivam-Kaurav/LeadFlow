import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/features/leads/presentation/bloc/leads_block/leads_bloc.dart';
import 'package:leadflow/features/leads/presentation/screens/filter_bottom_sheet.dart';
import 'package:leadflow/features/leads/presentation/widgets/lead_card.dart';
import 'package:leadflow/features/leads/presentation/widgets/lead_card_shimmer.dart';
import 'package:leadflow/features/leads/presentation/widgets/lead_search_bar.dart';
import 'package:leadflow/features/leads/presentation/widgets/leads_filter_tabs.dart';
import 'package:leadflow/features/leads/presentation/widgets/manage_leads_header.dart';

class ManageLeadsScreen extends StatefulWidget {
  const ManageLeadsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ManageLeadsScreenState();
}

class _ManageLeadsScreenState extends State<ManageLeadsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollControler = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollControler.dispose();
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
              onFilterTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<LeadsBloc>(),
                      child: const FilterBottomSheet(),
                    );
                  },
                );
              },
              onSearchChanged: (value) {
                print(" UI EVENT: $value");

                context.read<LeadsBloc>().add(SearchLeadsEvent(value));
              },
              onSavedTap: () {},
            ),
            const SizedBox(height: 10),
            BlocBuilder<LeadsBloc, LeadsState>(
              builder: (context, state) {
                if (state is LeadsLoaded) {
                  return LeadsFilterTabs(
                    filters: const [
                      'All',
                      'Fresh',
                      'Pending',
                      'Meeting',
                      'Site Visit',
                    ],
                    selected: state.selectedFilter,
                    onSelected: (value) {
                      context.read<LeadsBloc>().add(FilterLeadsEvent(value));
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<LeadsBloc, LeadsState>(
                builder: (context, state) {
                  if (state is LeadsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is LeadsLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<LeadsBloc>().add(RefreshLeadsEvent());
                      },
                      child: ListView.builder(
                        controller: _scrollControler,
                        physics: const AlwaysScrollableScrollPhysics(),

                        itemCount: state.leads.length + (state.hasMore ? 3 : 1),

                        itemBuilder: (context, index) {
                          ///  NORMAL ITEMS
                          if (index < state.leads.length) {
                            return LeadCard(lead: state.leads[index]);
                          }

                          // PAGINATION TRIGGER (ONLY ON FIRST EXTRA ITEM)
                          if (index == state.leads.length) {
                            if (!state.isLoadingMore && state.hasMore) {
                              context.read<LeadsBloc>().add(
                                LoadMoreLeadsEvent(),
                              );
                            }
                          }

                          /// 🔥 SHIMMER ITEMS
                          return const LeadCardShimmer();
                        },
                      ),
                    );
                  }
                  if (state is LeadsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
