import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        centerTitle: true,
        actions: [Icon(Icons.menu), SizedBox(width: 10)],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/khmer.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          // title
                          Text(
                            "កងទ័ពកម្ពុជាដ៏លាហាន",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          // subtitle
                          Text(
                            "កងទ័ពកម្ពុជាដ៏៏ក្លាហានបំផុត",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                child: Image.asset(
                                  "assets/khmer.jpg",
                                  width: 15,
                                  height: 15,
                                ),
                                radius: 10,
                              ),
                              Text(
                                "Saybay news",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.incomplete_circle_outlined,
                                color: Colors.grey,
                              ),
                              Text(
                                "4h ago",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
