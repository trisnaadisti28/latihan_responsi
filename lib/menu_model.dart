class MenuModel {
  final String title;
  final String img;
  final String desc;

  MenuModel({
    required this.title,
    required this.img,
    required this.desc});
}

  List<MenuModel> menuList = [
    MenuModel(
      title: 'News',
      img: 'assets/images/news.png',
      desc: 'Dapatkan berita lengkap terkait space'),
    MenuModel(
      title: 'Blog',
      img: 'assets/images/blog.png',
      desc: 'Dapatkan blog lengkap terkait space'),
    MenuModel(
      title: 'Report',
      img: 'assets/images/reports.png',
      desc: 'Dapatkan reports lengkap terkait space'),
  ];