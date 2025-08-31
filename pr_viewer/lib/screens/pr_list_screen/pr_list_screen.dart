import 'package:flutter/material.dart';
import 'package:pr_viewer/screens/pr_list_screen/pr_list_item.dart';
import 'package:pr_viewer/screens/pr_list_screen/pr_list_vm.dart';

import 'package:provider/provider.dart';

import '../error_display.dart';
import '../loading_indicator.dart';

class PrListScreen extends StatefulWidget {
  static const routeName = 'pr_list_screen';

  const PrListScreen({super.key});

  @override
  State<PrListScreen> createState() => _PrListScreenState();
}

class _PrListScreenState extends State<PrListScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return PrListViewModel();
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<PrListViewModel>(
      builder: (context, vm, __) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Text('Open Pull Requests'),
            backgroundColor: Colors.indigo[600],
          ),
          body: _body(context, vm),
        );
      },
    );
  }

  Widget _body(BuildContext context, PrListViewModel vm) {
    return Column(children: [Expanded(child: _buildBody(context, vm))]);
  }

  Widget _buildBody(BuildContext context, PrListViewModel vm) {
    switch (vm.state) {
      case PrListState.initial:
      case PrListState.loading:
        return const LoadingIndicator();
      case PrListState.loaded:
        if (vm.pullRequests.isEmpty) {
          return const Center(child: Text('No open pull requests found.'));
        }
        return RefreshIndicator(
          onRefresh: vm.fetchPullRequests,
          child: ListView.builder(
            itemCount: vm.pullRequests.length,
            itemBuilder: (context, index) {
              final pr = vm.pullRequests[index];
              return PrListItem(pr: pr);
            },
          ),
        );
      case PrListState.error:
        return ErrorDisplay(
          message: vm.errorMessage ?? 'An unknown error occurred.',
          onRetry: vm.fetchPullRequests,
        );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
