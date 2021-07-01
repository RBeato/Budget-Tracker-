import 'package:budget_tracker/budget_repository.dart';
import 'package:budget_tracker/failure_model.dart';
import 'package:budget_tracker/item_container.dart';
import 'package:budget_tracker/item_model.dart';
import 'package:budget_tracker/spending_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late Future<List<Item>> _futureItems;
  BudgetRepository budgetRepository = BudgetRepository(client: http.Client());

  @override
  void initState() {
    super.initState();
    _futureItems = budgetRepository.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Budget Tracker'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _futureItems = budgetRepository.getItems();
            setState(() {});
          },
          child: FutureBuilder<List<Item>>(
              future: _futureItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //show pie chart and list view of items.
                  final items = snapshot.data!;
                  return ListView.builder(
                      itemCount: items.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) return SpendingChart(items: items);

                        final item = items[index - 1];
                        return ItemContainer(item: item);
                      });
                } else if (snapshot.hasError) {
                  //Show failure error message
                  final failure = snapshot.error as Failure;
                  return Center(child: Text(failure.message));
                }
                //Show a loading spinner
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
