class Categories {
  final int idcategory;
  final String categoryname;

  Categories({
    required this.idcategory,
    required this.categoryname,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        idcategory: json['idcategory'],
        categoryname: json['categoryname'],
      );
}

class Founds {
  final int idfound;
  final int idobject;
  final int idlocation;
  final int? idfinder;
  final String findername;
  final DateTime founddate;
  final DateTime? created_at;
  final String? locationname;

  Founds({
    required this.idfound,
    required this.idobject,
    required this.idlocation,
    this.idfinder,
    required this.findername,
    required this.founddate,
    this.created_at,
    this.locationname,
  });

  factory Founds.fromJson(Map<String, dynamic> json) => Founds(
        idfound: json['idfound'],
        idobject: json['idobject'],
        idlocation: json['idlocation'],
        idfinder: json['idfinder'],
        findername: json['findername'],
        founddate: DateTime.parse(json['founddate']),
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        locationname:
            json['locationname'] != null ? json['locationname']['name'] : null,
      );
}

class Images {
  final int idimage;
  final int idobject;
  final Map<String, dynamic>? image;
  final DateTime? created_at;

  Images({
    required this.idimage,
    required this.idobject,
    this.image,
    this.created_at,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        idimage: json['idimage'],
        idobject: json['idobject'],
        image: json['image'],
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      );

  List<int>? getImageBytes() {
    if (image != null && image!['data'] != null) {
      return List<int>.from(image!['data']);
    }
    return null;
  }
}

class Locations {
  final int idlocation;
  final String name;
  final String address;
  final String? description;
  final DateTime? created_at;
  final List<Founds>? founds;

  Locations({
    required this.idlocation,
    required this.name,
    required this.address,
    this.description,
    this.created_at,
    this.founds,
  });

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        idlocation: json['idlocation'],
        name: json['name'],
        address: json['address'],
        description: json['description'],
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        founds: (json['founds'] as List)
            .map((found) => Founds.fromJson(found))
            .toList(),
      );
}

class Objects {
  final int idobject;
  final int iduser;
  final String name;
  final int idcategory;
  final String? description;
  final DateTime? created_at;
  final List<Founds> founds;
  final List<Images> images;
  final Categories? categories;
  final List<Returneds> returneds;

  Objects({
    required this.idobject,
    required this.iduser,
    required this.name,
    required this.idcategory,
    this.description,
    this.created_at,
    required this.founds,
    required this.images,
    this.categories,
    required this.returneds,
  });

  factory Objects.fromJson(Map<String, dynamic> json) => Objects(
      idobject: json['idobject'],
      iduser: json['iduser'],
      name: json['name'],
      idcategory: json['idcategory'],
      description: json['description'],
      created_at: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      founds: List<Founds>.from(json['founds'].map((x) => Founds.fromJson(x))),
      images: List<Images>.from(json['images'].map((x) => Images.fromJson(x))),
      categories: json['categories'] != null
          ? Categories.fromJson(json['categories'])
          : null,
      returneds: List<Returneds>.from(
          json['returneds'].map((x) => Returneds.fromJson(x))));
}

class Returneds {
  final int idreturned;
  final int idobject;
  final int? idreturner;
  final String returnername;
  final DateTime returndate;
  final DateTime? created_at;

  Returneds({
    required this.idreturned,
    required this.idobject,
    this.idreturner,
    required this.returnername,
    required this.returndate,
    this.created_at,
  });

  factory Returneds.fromJson(Map<String, dynamic> json) => Returneds(
        idreturned: json['idreturned'],
        idobject: json['idobject'],
        idreturner: json['idreturner'],
        returnername: json['returnername'],
        returndate: DateTime.parse(json['returndate']),
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
      );
}

class Status {
  final int idstatus;
  final String statusname;
  final List<StatusHistory>? status_history;
  Status({
    required this.idstatus,
    required this.statusname,
    this.status_history,
  });
  factory Status.fromJson(Map<String, dynamic> json) => Status(
        idstatus: json['idstatus'],
        statusname: json['statusname'],
        status_history: (json['status_history'] as List)
            .map((statusHistory) => StatusHistory.fromJson(statusHistory))
            .toList(),
      );
}

class StatusHistory {
  final int idhistory;
  final int idobject;
  final int idstatus;
  final DateTime statuschangedate;
  final Objects objects;
  final Status status;
  StatusHistory({
    required this.idhistory,
    required this.idobject,
    required this.idstatus,
    required this.statuschangedate,
    required this.objects,
    required this.status,
  });
  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
        idhistory: json['idhistory'],
        idobject: json['idobject'],
        idstatus: json['idstatus'],
        statuschangedate: DateTime.parse(json['statuschangedate']),
        objects: Objects.fromJson(json['objects']),
        status: Status.fromJson(json['status']),
      );
}

class Users {
  final int iduser;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role;
  final DateTime? created_at;
  final List<Founds>? founds;
  final List<Objects>? objects;
  final List<Returneds>? returneds;
  Users({
    required this.iduser,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    this.created_at,
    this.founds,
    this.objects,
    this.returneds,
  });
  factory Users.fromJson(Map<String, dynamic> json) => Users(
        iduser: json['iduser'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        role: json['role'],
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        founds: json['founds'] != null
            ? List<Founds>.from(json['founds'].map((x) => Founds.fromJson(x)))
            : null,
        objects: json['objects'] != null
            ? List<Objects>.from(
                json['objects'].map((x) => Objects.fromJson(x)))
            : null,
        returneds: json['returneds'] != null
            ? List<Returneds>.from(
                json['returneds'].map((x) => Returneds.fromJson(x)))
            : null,
      );
}
