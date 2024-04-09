class ChatMessageModel{
  final String role;
  final List<ChatPartsModel>parts;

  ChatMessageModel({required this.role,required this.parts});

  Map<String,dynamic>toMap(){
     return{
       'role':role,
       'parts':parts.map((x) =>x.toMap()).toList(),
     };
  }
  factory ChatMessageModel.fromMap(Map<String,dynamic>map){
    return ChatMessageModel(role: map['role'],
        parts: List<ChatPartsModel>.from(map['parts']?.map((x)=>ChatPartsModel(text: x['parts'])))
    );
  }
}

class ChatPartsModel{
 final  String text;

  ChatPartsModel({required this.text});

  Map<String,dynamic>toMap(){
    return{
      'text':text,
    };
  }
  factory ChatPartsModel.fromMap(Map<String,dynamic>map){
    return ChatPartsModel(text: map['text']);
  }
}