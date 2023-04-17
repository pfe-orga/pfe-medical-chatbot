import 'package:flutter/material.dart';
import '../controllers/HomeController.dart';
import '../data/models/weatherModel.dart';
import '../di/service_locator.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: AddWeatherBtn(),
      body: FutureBuilder<List<WeatherModel>>(
        future: homeController.getWfs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: " + error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final wf = snapshot.data![index];
                return ListTile(
                  title: Text(wf.date.toString() ),
                  subtitle: Text(wf.currentDate.toString()),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

class AddWeatherBtn extends StatelessWidget {
   AddWeatherBtn({Key? key}) : super(key: key);
  final homeController = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: homeController.dateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "date"),
            ),
            ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: homeController.currentDateController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password"),
            )
          )

              ],

            ),
      )),
    );
  }
}
