import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'countries_model.dart';
import 'covid_data_source.dart';

class PageDetailCountries extends StatefulWidget {
  const PageDetailCountries({Key? key}) : super(key: key);
  @override
  _PageDetailCountriesState createState() => _PageDetailCountriesState();
}

class _PageDetailCountriesState extends State<PageDetailCountries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card List Countries"),
      ),
      body: _buildDetailCountriesBody(),
    );
  }

  Widget _buildDetailCountriesBody() {
    return Container(
      child: FutureBuilder(
        future: CovidDataSource.instance.loadCountries(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            CountriesModel countriesModel =
                CountriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(countriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildEmptySection() {
    return Text("Empty");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(CountriesModel data) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(201, (index) {
        return Card(
          elevation: 10,
          child: _buildItemCountries("${data.countries?[index].name}",
              "\(${data.countries?[index].iso3}\)"),
        );
      }),
    );
  }

  Widget _buildItemCountries(String value1, String value2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          value1,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value2,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );

    // return Align(
    //   alignment: Alignment.center,
    //   child: Text(value),
    // );
  }
}
