import 'dart:convert';

import 'package:e_app/model/AllNews.dart';
import 'package:e_app/model/Connetion.dart';
import 'package:e_app/pages/Details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';


class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeallState();
}

class _SeeallState extends State<SeeAll> {
  // get all news
  List<Data> newsList = [];
  bool isLoading = false;

  Future<void> getNews() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String url = "${Connetion.conn}/front/news";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(response.body);
        final result = (decodedBody['data'] as List<dynamic>?) ?? [];

        setState(() {
          newsList = result.map((e) => Data.fromJson(e)).toList();
          isLoading = false;
        });
        print("result ${result}");
        print("Data ${newsList.toString()}");
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (error) {
      print("Error fetching data: $error");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  // smart refresh
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await getNews();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getNews();
    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("See All"), centerTitle: true),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : newsList.isEmpty
                    ? Center(
                      child: Text(
                        "No news available.",
                        style: TextStyle(fontSize: 22.00),
                      ),
                    )
                    : GridView.builder(
                      shrinkWrap: true,
                      // Important to make it work inside a Column
                      physics: NeverScrollableScrollPhysics(),
                      // Disable inner scroll
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      padding: EdgeInsets.all(8.0),
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey.withOpacity(0.1),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: Column(
                                // image
                                children: [
                                  ImageNetwork(

                                    image: newsList[index].image?.trim() ?? '',
                                    height: 90,
                                    width: 150,
                                    duration: 1500,
                                    curve: Curves.easeIn,
                                    onPointer: true,
                                    debugPrint: false,
                                    backgroundColor: Colors.grey.withOpacity(0.1),
                                    fitAndroidIos: BoxFit.cover,
                                    fitWeb: BoxFitWeb.cover,
                                    onLoading: const CircularProgressIndicator(
                                      color: Colors.indigoAccent,
                                    ),
                                    onError: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(
                                        title: newsList[index].title,
                                        subtitle: newsList[index].subtitle,
                                        describtion: newsList[index].description,
                                        image: newsList[index].image,
                                        logo: newsList[index].logo,
                                        author: newsList[index].author,
                                        createdAtAgo: newsList[index].createdAtAgo,
                                      ),));
                                    },
                                  ),
                                  // title
                                  Text(
                                    "${newsList[index].title}",
                                    style: TextStyle(fontSize: 14.0), maxLines: 1,
                                  ),
                                  Text(
                                    "${newsList[index].subtitle}",
                                    style: TextStyle(fontSize: 12.0), maxLines: 1,
                                  ),
                                  // describe
                                  Text(
                                    "${newsList[index].description}",
                                    style: TextStyle(fontSize: 12.0),
                                    maxLines: 1,
                                  ),
                                  // information
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.grey.withOpacity(0.1),
                                        child: ClipOval(
                                          child: newsList[index].logo != null
                                              ? ImageNetwork(
                                            image: newsList[index].logo!.trim(),
                                            height: 24,
                                            width: 24,
                                            duration: 1500,
                                            curve: Curves.easeIn,
                                            onPointer: true,
                                            debugPrint: false,
                                            backgroundColor: Colors.transparent,
                                            fitAndroidIos: BoxFit.cover,
                                            fitWeb: BoxFitWeb.cover,
                                            onLoading: const CircularProgressIndicator(
                                              color: Colors.indigoAccent,
                                            ),
                                            onError: const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          )
                                              : const Icon(Icons.image_not_supported),
                                        ),
                                      ),

                                      const SizedBox(width: 4),
                                      Text(
                                        "${newsList[index].author}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.incomplete_circle_outlined,
                                        color: Colors.grey,
                                        size: 12.0,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        newsList[index].createdAtAgo.toString(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
