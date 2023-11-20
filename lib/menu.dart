import 'package:flutter/material.dart';
import 'api_data_source.dart';
import 'menu_model.dart';
import 'news_model.dart';
import 'blogs_model.dart';
import 'package:latihan_responsi/reports_model.dart';

void main() {
  runApp(MaterialApp(
    home: MenuPage(),
  ));
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu',
            style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue, // Ganti warna latar belakang app bar
      ),
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          MenuModel menu = menuList[index];
          return MenuCard(menu: menu);
        },
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final MenuModel menu;

  MenuCard({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(8.0),
      elevation: 4.0, // Menambahkan elevasi untuk efek shadow
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListPage(title: menu.title),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                image: DecorationImage(
                  image: AssetImage(menu.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    menu.desc,
                    style: TextStyle(color: Colors.grey[600]),
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

class ListPage extends StatefulWidget {
  final String title;

  const ListPage({required this.title});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    var endpoint = widget.title == 'news' ? 'articles' : widget.title;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.title.toUpperCase()} LIST',
            style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue, // Ganti warna latar belakang app bar
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadList(endpoint),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _buildErrorSection();
          } else if (snapshot.hasData) {
            if (widget.title == 'news') {
              News news = News.fromJson(snapshot.data!);
              return _buildNews(news);
            } else if (widget.title == 'blogs') {
              Blogs blogs = Blogs.fromJson(snapshot.data!);
              return _buildBlogs(blogs);
            } else if (widget.title == 'reports') {
              Reports reports = Reports.fromJson(snapshot.data!);
              return _buildReports(reports);
            }
          }
          return Center(child: Text("No data available."));
        },
      ),
    );
  }

  Widget _buildNews(News news) {
    return ListView.builder(
      itemCount: news.data!.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(news.data![index].title ?? ""),
            subtitle: Text(news.data![index].summary ?? ""),
            // Add other widgets as needed
          ),
        );
      },
    );
  }

  Widget _buildBlogs(Blogs blogs) {
    return ListView.builder(
      itemCount: blogs.data!.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(blogs.data![index].title ?? ""),
            subtitle: Text(blogs.data![index].summary ?? ""),
            // Add other widgets as needed
          ),
        );
      },
    );
  }

  Widget _buildReports(Reports reports) {
    return ListView.builder(
      itemCount: reports.data!.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(reports.data![index].title ?? ""),
            subtitle: Text(reports.data![index].summary ?? ""),
            // Add other widgets as needed
          ),
        );
      },
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 50, color: Colors.red),
          SizedBox(height: 10),
          Text(
            "Error loading data. Please try again later.",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
