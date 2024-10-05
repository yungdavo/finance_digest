import 'package:finance_digest/customs/news_list.dart';
import 'package:finance_digest/data/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/news_model.dart';
import 'error_screen.dart';



class DashBoard extends StatefulWidget {
  final String firstName;
  const DashBoard({super.key, required this.firstName});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  late Future <List<NewsArticleModel>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = NewsData().getNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF000000),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(0xff05021B),
          title: Text(
            "Hey ${widget.firstName}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp, fontWeight: FontWeight.w900,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: FutureBuilder<List<NewsArticleModel>>(
          future: futureArticles,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()
              );
            }else if (snapshot.hasError){
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                  MaterialPageRoute(builder: (context) => ErrorScreen()),
                  );
                },
                  child: Padding(
                    padding:  EdgeInsets.only(left: 16, right: 19),
                    child: Container(

                      height: 24, width: 400,
                      child: Text(
                          "Something went wrong. Please try again later.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rubik',
                          ),
                        ),
                    ),
                  ),
                  );

            }else if (!snapshot.hasData || snapshot.data!.isEmpty){

              return Center(child: Text('No news articles found'));
            }
            final articles = snapshot.data!;

            return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index){
                  final article = articles[index];
                  return GestureDetector(
                    onTap: (){
                      _launchURL(article.url);
                    },
                    child: newsList(
                        imageUrl: article.image,
                        source: article.source,
                        date: DateFormat('dd MMMM yyyy')
                            .format(
                            DateTime.fromMillisecondsSinceEpoch(
                                article.datetime * 1000),
                        ),
                        headline: article.headline
                    ),
                  );
                });

          },
        )
    );
  }
  void _launchURL(String url) async {
    if (url.isEmpty) {
      // Handle case where URL is empty
      print('URL is empty');
      return;
    }

    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not launch $url"),
          ),
      );
    }
  }
}
