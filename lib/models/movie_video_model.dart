import 'dart:convert';

class MovieVideoModel {
    MovieVideoModel({
        this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type,
    });

    final String id;
    final String iso6391;
    final String iso31661;
    final String key;
    final String name;
    final String site;
    final int size;
    final String type;

    factory MovieVideoModel.fromJson(String str) => MovieVideoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MovieVideoModel.fromMap(Map<String, dynamic> json) => MovieVideoModel(
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        key: json["key"],
        name: json["name"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "key": key,
        "name": name,
        "site": site,
        "size": size,
        "type": type,
    };
}