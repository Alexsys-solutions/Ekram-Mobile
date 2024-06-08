class CardItem {
  final int id;


  CardItem({required this.id, });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
  
    );
  }
}
