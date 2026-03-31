import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leadflow/core/network/dio_client.dart';
import 'package:leadflow/core/theme/app_theme.dart';
import 'package:leadflow/features/leads/data/datasources/lead_remote_datasource.dart';
import 'package:leadflow/features/leads/data/repositories/lead_repository_impl.dart';
import 'package:leadflow/features/leads/domain/usecases/get_leads.dart';
import 'package:leadflow/features/leads/presentation/bloc/leads_bloc.dart';
import 'package:leadflow/features/leads/presentation/screens/manage_leads_screen.dart';

void main() {
  final dioClient = DioClient();
  final dataSource = LeadRemoteDatasourceImpl(dioClient);
  final repository = LeadRepositoryImpl(dataSource);
  final getLeads = GetLeads(repository: repository);
  runApp(MyApp(getLeads: getLeads));
}

class MyApp extends StatelessWidget {
  final GetLeads getLeads;

  const MyApp({super.key, required this.getLeads});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leadflow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => LeadsBloc(getLeads)..add(LoadLeadsEvent()),
        child: ManageLeadsScreen(),
      ),
    );
  }
}
