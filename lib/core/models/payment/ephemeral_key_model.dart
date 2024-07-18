class EphemeralKeyObjectModel {
  final String id;
  final String object;
  final List<AssociatedObject> associatedObjects;
  final int created;
  final int expires;
  final bool livemode;
  final String secret;

  EphemeralKeyObjectModel({
    required this.id,
    required this.object,
    required this.associatedObjects,
    required this.created,
    required this.expires,
    required this.livemode,
    required this.secret,
  });

  factory EphemeralKeyObjectModel.fromJson(Map<String, dynamic> json) =>
      EphemeralKeyObjectModel(
        id: json["id"],
        object: json["object"],
        associatedObjects: List<AssociatedObject>.from(
            json["associated_objects"]
                .map((x) => AssociatedObject.fromJson(x))),
        created: json["created"],
        expires: json["expires"],
        livemode: json["livemode"],
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "associated_objects":
            List<dynamic>.from(associatedObjects.map((x) => x.toJson())),
        "created": created,
        "expires": expires,
        "livemode": livemode,
        "secret": secret,
      };
}

class AssociatedObject {
  final String id;
  final String type;

  AssociatedObject({
    required this.id,
    required this.type,
  });

  factory AssociatedObject.fromJson(Map<String, dynamic> json) =>
      AssociatedObject(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
