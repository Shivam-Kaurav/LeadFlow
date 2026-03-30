import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/core/theme/app_theme.dart';
import 'package:leadflow/features/leads/presentation/bloc/leads_bloc.dart';
import 'package:leadflow/features/leads/presentation/screens/manage_leads_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leadflow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => LeadsBloc()..add(LoadLeadsEvent()),
        child: ManageLeadsScreen(),
      ),
    );
  }
}
