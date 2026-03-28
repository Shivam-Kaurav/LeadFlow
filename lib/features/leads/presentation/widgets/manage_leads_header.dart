import 'package:flutter/material.dart';

class ManageLeadsHeader extends StatelessWidget {
  const ManageLeadsHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          //left section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Manage Leads',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'manage all your leads under a single screen',
                  style: TextStyle(color: Colors.grey),
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
