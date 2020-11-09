import 'dart:convert';

import 'movie_video_model.dart';

class MovieVideoResponse {
    MovieVideoResponse({
        this.id,
        this.movieVideos,
    });

    final int id;
    final List<MovieVideoModel> movieVideos;

    factory MovieVideoResponse.fromJson(String str) => MovieVideoResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovieVideoResponse.fromMap(Map<String, dynamic> json) => MovieVideoResponse(
        id: json["id"],
        movieVideos: List<MovieVideoModel>.from(json["results"].map((x) => MovieVideoModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "results": List<dynamic>.from(movieVideos.map((x) => x.toMap())),
    };
}


