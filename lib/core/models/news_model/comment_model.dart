import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String? commentSentiment;

  const CommentModel({this.commentSentiment});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentSentiment: json['Comment Sentiment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Comment Sentiment': commentSentiment,
      };

  @override
  List<Object?> get props => [commentSentiment];
}
