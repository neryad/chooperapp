import 'package:chooperapp/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'services/post_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PostService.create(),
      dispose: (_, PostService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
