class Meta {
  Meta({
    this.lastPage,
  });

  Meta.fromJson(dynamic json) {
    lastPage = json['last_page'];
  }

  num? lastPage;
}
