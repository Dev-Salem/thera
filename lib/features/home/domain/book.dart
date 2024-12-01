// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  final String id;
  final String category;
  final String name;
  final String description;
  final String author;
  final String coverLink;
  final String downloadLink;
  Book({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.author,
    required this.coverLink,
    required this.downloadLink,
  });


  Book copyWith({
    String? id,
    String? category,
    String? name,
    String? description,
    String? author,
    String? coverLink,
    String? downloadLink,
  }) {
    return Book(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
      author: author ?? this.author,
      coverLink: coverLink ?? this.coverLink,
      downloadLink: downloadLink ?? this.downloadLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'book_name': name,
      'description': description,
      'author': author,
      'coverLink': coverLink,
      'downloadLink': downloadLink,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      category: map['categories'] as String,
      name: map['book_name'] as String,
      description: map['brief_text'] as String,
      author: map['author_name'] as String,
      coverLink: map['cover_link'] as String,
      downloadLink: map['book_link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source, String id) => Book.fromMap(json.decode(source) as Map<String, dynamic>, id);

  @override
  String toString() {
    return 'Book(id: $id, category: $category, name: $name, description: $description, author: $author, coverLink: $coverLink, downloadLink: $downloadLink)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.category == category &&
      other.name == name &&
      other.description == description &&
      other.author == author &&
      other.coverLink == coverLink &&
      other.downloadLink == downloadLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      category.hashCode ^
      name.hashCode ^
      description.hashCode ^
      author.hashCode ^
      coverLink.hashCode ^
      downloadLink.hashCode;
  }
}
