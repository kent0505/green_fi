class NW {
  NW({
    required this.title,
    required this.content,
    required this.publishedDate,
    required this.imageURL,
  });

  final String title;
  final String content;
  final String publishedDate;
  final String imageURL;
}

List<NW> nwLIST = [
  NW(
    title: '',
    content: '',
    publishedDate: '',
    imageURL: '',
  ),
  // 10-15 новостей
];
