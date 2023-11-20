import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'news_model.dart';

class PageListNews extends StatefulWidget {
  const PageListNews({super.key});

  @override
  State<PageListNews> createState() => _PageListNewsState();
}

class _PageListNewsState extends State<PageListNews> {
  String? get endpoint => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News List"),
        centerTitle: true,
      ),
      body: _buildListNewsBody(),
    );
  }

  Widget _buildListNewsBody(){
    return Container(
      child: FutureBuilder(
          future: ApiDataSource.instance.loadList(endpoint!),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasError){
              return _buildErrorSection();
            }
            if(snapshot.hasData){
              News news =
              News.fromJson(snapshot.data);
              return _buildSuccessSection(news);

            }
            return _buildLoadingSection();
          }
      ),
    );
  }

  Widget _buildErrorSection(){
    return Text("Error");
  }

  Widget _buildLoadingSection(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(News data){
    return ListView.builder(
        itemCount: data.data!.length,
        itemBuilder: (BuildContext context, int index){
          return _buildItemNews(data.data![index]);
        }
    );
  }

  Widget _buildItemNews(Data news){
    return InkWell(
      onTap: () => null,
      // Navigator.push(
      // context,
      // MaterialPageRoute(
      //     builder: (context) => PageDetailUser(idUser: userData.id!,))),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(news.imageUrl!),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(news.title!),
                Text(news.updatedAt!),
              ],
            )
          ],
        ),
      ),
    );
  }
}



/*class NewsPage extends StatelessWidget {
  final News news;

  NewsPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News List'),
        centerTitle: true,
      ),
      body: _buildNewsList(context),
    );
  }

  Widget _buildNewsList(BuildContext context) {
    if (news.data != null && news.data!.isNotEmpty) {
      return ListView.builder(
        itemCount: news.data!.length,
        itemBuilder: (context, index) {
          Data newsData = news.data![index];
          return _buildNewsItem(context, newsData);
        },
      );
    } else {
      return Center(
        child: Text('No news available.'),
      );
    }
  }

  Widget _buildNewsItem(BuildContext context, Data newsData) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(newsData.title ?? ''),
        subtitle: Text(newsData.summary ?? ''),
        onTap: () {
          // Navigasi ke halaman detail berita atau lakukan tindakan khusus
          _handleNewsTap(context, newsData);
        },
      ),
    );
  }

  void _handleNewsTap(BuildContext context, Data newsData) {
    // Contoh: Navigasi ke halaman detail berita dengan membawa data berita
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(newsData: newsData),
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final Data newsData;

  NewsDetailPage({required this.newsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsData.title ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(newsData.summary ?? ''),
            // Add other widgets as needed for displaying detailed news information
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NewsPage(
      news: News(
        count: 2,
        next: null,
        previous: null,
        data: [
          Data(
            // Data berita 1
          ),
          Data(
            // Data berita 2
          ),
        ],
      ),
    ),
  ));
}*/
