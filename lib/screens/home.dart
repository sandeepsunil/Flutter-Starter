import 'package:flutter/material.dart';
import 'package:flutter_starter/models/requests/req_sample.dart';
import 'package:flutter_starter/models/responses/res_sample.dart';
import 'package:flutter_starter/services/sample.service.dart';
import 'package:flutter_starter/utils/http_response.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SampleReq sampleReq = SampleReq(
      id: 12, name: 'Manuel', username: 'manuel', email: 'manuel@gmail.com');

  SampleService sampleService = SampleService();

  late SampleRes sampleRes =
      SampleRes(id: -1, email: '', name: '', phone: '', username: '');

  Future<void> sendReq() async {
    HTTPResponse? response =
        await sampleService.getUserList(sampleReq.toJson());
    if (response?.status == 200) {
      setState(() {
        sampleRes = SampleRes.fromJson(response?.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  '${sampleRes.toJson()}',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                )),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  child: Text('Send request'),
                  onPressed: () async {
                    sendReq();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
