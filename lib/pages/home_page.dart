import 'package:earthquake_app/provider/app_data_provider.dart';
import 'package:earthquake_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    Provider.of<AppDataProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EarthQuake Info'),
      ),
      body: Consumer<AppDataProvider>(
        builder: (context, provider, child) =>
        provider.hasDataLoaded ?
        provider.earthquakeModel!.features!.isEmpty ?
        const Center(
          child: Text('No Record Found !'),) :
        ListView.builder(
          itemCount: provider.earthquakeModel!.features!.length,
          itemBuilder: (BuildContext context, int index) {
            final data = provider.earthquakeModel!.features![index].properties!;
            return ListTile(
              title: Text(data.place ?? data.title ?? 'Unknown'),
              subtitle: Text(
                  getFormattedDateTime(data.time!, 'EEE MMM dd yyyy hh:mm a')),
              trailing: Chip(
                avatar: data.alert == null ? null : CircleAvatar(
                  backgroundColor: provider.getAlertColor(data.alert!),
                ),
                label: Text(
                    '${data.mag}'
                ),
              ),
            );
          },
        ) : const Center(
          child: Text('Please Wait, Data is Loading !'),
        ),
      ),
    );
  }
}
