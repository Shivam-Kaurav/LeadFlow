import 'package:flutter/material.dart';

class LeadSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;
  final VoidCallback onSavedTap;
  final ValueChanged<String> onSearchChanged;

  const LeadSearchBar({
    super.key,
    required this.controller,
    required this.onFilterTap,
    required this.onSavedTap,
    required this.onSearchChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //search bar
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: onSearchChanged,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search leads...',
                suffixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        //saved filters
        _iconButton(context, icon: Icons.bookmark_outline, onTap: onSavedTap),

        const SizedBox(width: 10),

        //apply filters button
        _iconButton(context, icon: Icons.filter_list, onTap: onFilterTap),
      ],
    );
  }

  //reusable icon button
  Widget _iconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon),
      ),
    );
  }
}
