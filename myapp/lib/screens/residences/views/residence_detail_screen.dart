import 'package:flutter/material.dart';
import 'package:residence_repository/residence_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ResidenceDetailScreen extends StatelessWidget {
  final Residence residence;

  ResidenceDetailScreen({Key? key, required this.residence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(residence.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(residence.image, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(residence.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text(residence.address),
                  Text('Capacity: ${residence.capacity}'),
                  Text('Country: ${residence.country}'),
                  InkWell(
                    // onTap: () => launchUrl(residence.url),
                    child: Text('Visit Website', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
