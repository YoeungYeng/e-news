import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class Details extends StatefulWidget {
  const Details({
    super.key,
    required this.title,
    required this.describtion,
    required this.image,
    required this.subtitle,
    required this.logo,
    required this.author,
    required this.createdAtAgo
  });

  final title, subtitle, describtion, image, logo, author, createdAtAgo;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Love Cambodia"), centerTitle: true),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // image
                    Container(
                      child: ImageNetwork(
                        image: widget.image ?? '',
                        height: 400,
                        width: 400,

                        fitAndroidIos: BoxFit.cover,
                        fitWeb: BoxFitWeb.cover,
                        onPointer: true,
                        debugPrint: false,
                      ),
                    ),
                    // title
                    Center(
                      child: Container(
                        child: Text(
                          "${widget.title}",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // subtitle
                          Text(
                            "${widget.subtitle}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          // describe
                          Text(
                            "${widget.describtion}",
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          child: ClipOval(
                            child: widget.logo != null
                                ? ImageNetwork(
                              image: widget.logo!.trim(),
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
                          "${widget.author}",
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
                          widget.createdAtAgo.toString(),
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
        ),
      ),
    );
  }
}
