import 'dart:convert';
import 'package:e_app/components/LastNews.dart';
import 'package:e_app/components/SeeAll.dart';
import 'package:e_app/pages/Details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_app/components/Trending.dart';
import 'package:e_app/model/Category.dart';
import 'package:e_app/model/Connetion.dart';
import 'package:e_app/model/FilterNews.dart';
import 'package:image_network/image_network.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.categoryId});

  final dynamic categoryId;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  int? selectedCategoryId;
  bool isLoading = false;

  List<Data> categoryList = [];
  List<Data2> filterNews = [];

  @override
  void initState() {
    super.initState();
    getCategoryAndFetchNews();
  }

  Future<void> getcategory() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String url = "${Connetion.conn}/front/category";

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
          categoryList = result.map((e) => Data.fromJson(e)).toList();
          isLoading = false;
        });
        print("result ${result}");
        print("Data ${categoryList.toString()}");
      } else {
        print("Failed to load data: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (error) {
      print("Error fetching data: $error");
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchNewsByCategory() async {
    if (selectedCategoryId == null) return;

    setState(() {
      isLoading = true;
    });

    final url = '${Connetion.conn}/front/news/$selectedCategoryId';

    print(url);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(response.body);
        final result = (decodedBody['data2'] as List<dynamic>?) ?? [];

        setState(() {
          filterNews = result.map((e) => Data2.fromJson(e)).toList();
          isLoading = false;
        });

        print("Fetched News: $result");
        print("Data2 ${filterNews.toString()}");
        //
      } else {
        print("Failed to load news: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> getCategoryAndFetchNews() async {
    await getcategory();
    if (categoryList.isNotEmpty) {
      selectedCategoryId = widget.categoryId ?? categoryList[0].id;
      selectedIndex = categoryList.indexWhere(
        (cat) => cat.id == selectedCategoryId,
      );
      await fetchNewsByCategory();
    }
  }

  // smart refresh
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await getcategory();
    await fetchNewsByCategory();
    await getCategoryAndFetchNews();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getcategory(); // Replace with pagination if needed
    await fetchNewsByCategory();
    await getCategoryAndFetchNews();
    _refreshController.loadComplete();
  }

  Widget getTabContent() {
    return SizedBox(
      height: 400,
      child:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : filterNews.isEmpty
              ? Center(
                child: Text(
                  "No news available.",
                  style: TextStyle(fontSize: 22.00),
                ),
              )
              : ListView.builder(
                itemCount: filterNews.length,
                padding: const EdgeInsets.all(10.0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ImageNetwork(
                            image: filterNews[index].image!.trim(),
                            height: 100,
                            width: 120,
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
                            onError: const Icon(Icons.error, color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    title: filterNews[index].title,
                                    subtitle: filterNews[index].subtitle,
                                    describtion: filterNews[index].description,
                                    image: filterNews[index].image,
                                    author: filterNews[index].author,
                                    logo: filterNews[index].logo,
                                    createdAtAgo: filterNews[index].createdAtAgo,
                                  ),
                                ),
                              );
                            },
                          )

                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filterNews[index].name.toString(),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                filterNews[index].subtitle.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                                maxLines: 2,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(
                                      0.1,
                                    ),
                                    child: ClipOval(
                                      child:
                                          filterNews[index].logo != null
                                              ? ImageNetwork(
                                                image:
                                                    filterNews[index].logo!
                                                        .trim(),
                                                height: 24,
                                                width: 24,
                                                duration: 1500,
                                                curve: Curves.easeIn,
                                                onPointer: true,
                                                debugPrint: false,
                                                backgroundColor:
                                                    Colors.transparent,
                                                fitAndroidIos: BoxFit.cover,
                                                fitWeb: BoxFitWeb.cover,
                                                onLoading:
                                                    const CircularProgressIndicator(
                                                      color:
                                                          Colors.indigoAccent,
                                                    ),
                                                onError: const Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              )
                                              : const Icon(
                                                Icons.image_not_supported,
                                              ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${filterNews[index].name}",
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
                                    filterNews[index].createdAtAgo.toString(),
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
                      ],
                    ),
                  );
                },
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "YOEUNG YENG",
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          const SizedBox(width: 10),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black87),
                        label: Text(
                          "search...",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Trending & See All
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Trending(),
                                ),
                              ),
                          child: const Text(
                            "Trending",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Card with sample news
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/army.jpg",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "កងទ័ពកម្ពុជាដ៏លាហាន",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            const Text(
                              "កងទ័ពកម្ពុជាដ៏៏ក្លាហានបំផុត",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Row(
                              children: const [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(
                                    "assets/khmer.jpg",
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Saybay news",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.incomplete_circle_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4h ago",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Lasts & See All
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Lastnews(),
                              ),
                            );
                          },
                          child: const Text("Lasts"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SeeAll()),
                            );
                          },
                          child: const Text("See All"),
                        ),
                      ],
                    ),

                    // Category Tab Bar
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selectedCategoryId = categoryList[index].id;
                              });
                              fetchNewsByCategory();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.orange : Colors.black87,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                categoryList[index].name.toString(),
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Filtered News Tab Content
                    getTabContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
