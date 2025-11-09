import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kitap Listesi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const BookListPage(),
    );
  }
}

class Book {
  const Book({
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  final String title;
  final String author;
  final String imageUrl;
}

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final List<Book> _books = const <Book>[
    Book(
      title: '1984',
      author: 'George Orwell',
      imageUrl: 'https://covers.openlibrary.org/b/id/8228691-L.jpg',
    ),
    Book(
      title: 'Yüzüklerin Efendisi: Yüzük Kardeşliği',
      author: 'J.R.R. Tolkien',
      imageUrl: 'https://covers.openlibrary.org/b/id/11314717-L.jpg',
    ),
    Book(
      title: 'Gurur ve Önyargı',
      author: 'Jane Austen',
      imageUrl: 'https://covers.openlibrary.org/b/id/10292061-L.jpg',
    ),
    Book(
      title: 'Bülbülü Öldürmek',
      author: 'Harper Lee',
      imageUrl: 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
    ),
    Book(
      title: 'Fahrenheit 451',
      author: 'Ray Bradbury',
      imageUrl: 'https://covers.openlibrary.org/b/id/10513969-L.jpg',
    ),
    Book(
      title: 'Dönüşüm',
      author: 'Franz Kafka',
      imageUrl: 'https://covers.openlibrary.org/b/id/10547191-L.jpg',
    ),
    Book(
      title: 'Hayvan Çiftliği',
      author: 'George Orwell',
      imageUrl: 'https://covers.openlibrary.org/b/id/10523361-L.jpg',
    ),
    Book(
      title: 'Suç ve Ceza',
      author: 'Fyodor Dostoyevski',
      imageUrl: 'https://covers.openlibrary.org/b/id/11092788-L.jpg',
    ),
  ];

  final Set<String> _favoriteTitles = <String>{};

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void _onBookTap(Book book) {
    _showSnackBar('Seçilen kitap: ${book.title}');
  }

  void _toggleFavorite(Book book) {
    setState(() {
      if (_favoriteTitles.contains(book.title)) {
        _favoriteTitles.remove(book.title);
        _showSnackBar('${book.title} favorilerden çıkarıldı');
      } else {
        _favoriteTitles.add(book.title);
        _showSnackBar('${book.title} favorilere eklendi');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kitap Listesi')),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final bool isLandscape = orientation == Orientation.landscape;
          final EdgeInsets padding = isLandscape
              ? const EdgeInsets.symmetric(horizontal: 32, vertical: 16)
              : const EdgeInsets.all(16);

          return ListView.builder(
            itemCount: _books.length,
            padding: padding,
            itemBuilder: (BuildContext context, int index) {
              final Book book = _books[index];
              final bool isFavorite = _favoriteTitles.contains(book.title);

              return _BookCard(
                book: book,
                isFavorite: isFavorite,
                isLandscape: isLandscape,
                onTap: () => _onBookTap(book),
                onFavoriteTap: () => _toggleFavorite(book),
              );
            },
          );
        },
      ),
    );
  }
}

class _BookCard extends StatelessWidget {
  const _BookCard({
    required this.book,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
    required this.isLandscape,
  });

  final Book book;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    final double coverWidth = isLandscape ? 90 : 60;
    final double coverHeight = isLandscape ? 130 : 90;
    final double spacing = isLandscape ? 20 : 16;
    final double verticalPadding = isLandscape ? 18 : 12;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.symmetric(vertical: isLandscape ? 12 : 8),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(verticalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BookCover(
                imageUrl: book.imageUrl,
                width: coverWidth,
                height: coverHeight,
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      book.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: isLandscape ? 20 : 18,
                      ),
                    ),
                    SizedBox(height: isLandscape ? 12 : 8),
                    Text(
                      book.author,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                color: isFavorite ? Colors.red : Colors.grey,
                onPressed: onFavoriteTap,
                tooltip: isFavorite ? 'Favorilerden çıkar' : 'Favorilere ekle',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(Icons.book, color: Colors.grey),
              );
            },
      ),
    );
  }
}
