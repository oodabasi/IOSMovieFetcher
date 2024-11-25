import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailsPage extends StatefulWidget {
  final Map movie;

  MovieDetailsPage({required this.movie});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeAnimation;
  Map<String, dynamic>? castData;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
    _controller!.forward();
    _fetchCastData();
  }

  _fetchCastData() async {
    final movieId = widget.movie['id'];
    final apiKey = '20d5092a928c73f98b8e8e3d8dbb4d1e'; // Replace with your TMDB API key
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        castData = data;
      });
    } else {
      // Handle API error
      print('Failed to fetch cast data');
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.blue, // Back button icon
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/arrowback.png', // Replace with your back button image
              width: 24,
              height: 24,
            ),
          ),
        ),
        title: Text(
          movie['title'],
          style: TextStyle(color: Colors.blue),
        ),
      ),
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeAnimation!,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Movie Banner (unchanged)
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Movie Details (unchanged)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Release Date: ${movie['release_date']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/star_icon.png', // Replace with your star icon
                          width: 20,
                          height: 20,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 4),
                        Text(
                          movie['vote_average'].toString(),
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      movie['overview'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Cast',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Cast section
              if (castData != null)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: castData!['cast'].length.clamp(0, 10), // Limit to 10 cast members
                  itemBuilder: (context, index) {
                    final castMember = castData!['cast'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w185${castMember['profile_path']}',
                        ),
                        radius: 30, // Profil fotoğrafı boyutunu ayarlayın
                      ),
                      title: Text(
                        castMember['name'],
                        style: TextStyle(color: Colors.blue),
                      ),
                      subtitle: Text(
                        'Character: ${castMember['character']}',
                        style: TextStyle(color: Colors.blue[300]),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}