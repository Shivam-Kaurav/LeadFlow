import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/features/leads/domain/entities/lead_filter.dart';
import 'package:leadflow/features/leads/presentation/bloc/leads_block/leads_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  final LeadFilter filter;
  const FilterBottomSheet({super.key, required this.filter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  DateTime? startDate;
  DateTime? endDate;
  late List<String> selectedStatuses;
  String? priority;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //prefill from bloc
    selectedStatuses = List.from(widget.filter.statuses);
    priority = widget.filter.priority;
    startDate = widget.filter.startDate;
    endDate = widget.filter.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 8,
            children: ['Fresh', 'Pending', 'Meeting', 'Site Visit'].map((
              status,
            ) {
              final isSelected = selectedStatuses.contains(status);

              return ChoiceChip(
                label: Text(status),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    isSelected
                        ? selectedStatuses.remove(status)
                        : selectedStatuses.add(status);
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          DropdownButton<String>(
            hint: const Text("Select Priority"),
            value: priority,
            items: [
              'High',
              'Medium',
              'Low',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => priority = val),
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickDate(context, true),
                  child: Text(
                    startDate == null
                        ? "Start Date"
                        : startDate!.toLocal().toString().split(' ')[0],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _pickDate(context, false),
                  child: Text(
                    endDate == null
                        ? "End Date"
                        : endDate!.toLocal().toString().split(' ')[0],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedStatuses.clear();
                    priority = null;
                    startDate = null;
                    endDate = null;
                  });

                  context.read<LeadsBloc>().add(
                    ApplyAdvancedFilterEvent(const LeadFilter()),
                  );
                },
                child: const Text("Reset"),
              ),
              ElevatedButton(
                onPressed: () {
                  final filter = LeadFilter(
                    statuses: selectedStatuses,
                    priority: priority,
                    startDate: startDate,
                    endDate: endDate,
                  );

                  context.read<LeadsBloc>().add(
                    ApplyAdvancedFilterEvent(filter),
                  );

                  Navigator.pop(context);
                },
                child: Text("Apply (${selectedStatuses.length}) Filters"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
