import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/controllers/movie_detail_controller.dart';
import 'package:movies/core/constants.dart';
import 'package:movies/widgets/centered_message.dart';
import 'package:movies/widgets/centered_progress.dart';
import 'package:movies/widgets/chip_date.dart';
import 'package:movies/widgets/custom_divider.dart';
import 'package:movies/widgets/rate.dart';
import 'package:movies/widgets/video/custom_video_player.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  MovieDetailPage(this.movieId);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovieById(widget.movieId);
    await _controller.fetchMovieVideo(widget.movieId);
    await _controller.fetchSimilarMovies(widget.movieId);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMovieDetail(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(_controller.movieDetail?.title ?? 'Loading...'),
    );
  }

  _buildMovieDetail() {
    if (_controller.loading) {
      return CenteredProgress();
    }
    if (_controller.movieError != null) {
      return CenteredMessage(message: _controller.movieError.message);
    }
    return ListView(
      children: [
        _buildCover(),
        _buildStatus(),
        _buildOverview(),
        _buildVideo(),
        _buildTextSimilarMovies(),
        _buildSimilarMovies()
      ],
    );
  }

  _buildTextSimilarMovies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(top: 20),
          child: const Text('Similar Movies', style: TextStyle(fontSize: 20)),
        ),
        CustomDivider(color: Colors.white, horizontalPadding: 10)
      ],
    );
  }

  _buildSimilarMovies() {
    if (_controller.similarMoviesCount == 0) {
      return CenteredMessage(
        message: 'No similar movies',
        icon: Icons.report,
        color: Colors.red,
      );
    }
    final height = MediaQuery.of(context).size.height * 0.35;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 20),
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: _similarMovieCard,
        itemCount: _controller.similarMoviesCount,
      ),
    );
  }

  Widget _similarMovieCard(BuildContext context, int index) {
    final posterPath = _controller.similarMovies[index].posterPath;
    final width = MediaQuery.of(context).size.width * 0.45;
    final movieId = _controller.similarMovies[index].id;
    return GestureDetector(
      onTap: () => _onTap(movieId),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: width,
        child: FancyShimmerImage(
          imageUrl: 'https://image.tmdb.org/t/p/w220_and_h330_face$posterPath',
          boxFit: BoxFit.fill,
          errorWidget: CenteredMessage(message: kImageError),
        ),
      ),
    );
  }

  _onTap(int movieId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movieId),
      ),
    );
  }

  _buildVideo() {
    final title = _controller.videos[0].name;
    final url = 'https://www.youtube.com/watch?v=' + _controller.videos[0].key;
    return CustomVideoPlayer(
      title: title,
      url: url,
    );
  }

  _buildOverview() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Text(
        _controller.movieDetail.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Rate(value: _controller.movieDetail.voteAverage),
          const SizedBox(width: 20.0),
          ChipDate(date: _controller.movieDetail.releaseDate)
        ],
      ),
    );
  }

  _buildCover() {
    return FancyShimmerImage(
      imageUrl:
          'https://image.tmdb.org/t/p/w500${_controller.movieDetail.backdropPath}',
      errorWidget: const CenteredMessage(message: kImageError),
      boxFit: BoxFit.cover,
    );
  }
}
