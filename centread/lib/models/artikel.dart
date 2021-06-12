class ArtikelM {
  final int idartikel;
  final String judulartikel;
  final String isiartikel;
  final String gambarartikel;

  ArtikelM(
      this.idartikel, this.judulartikel, this.isiartikel, this.gambarartikel);

  ArtikelM.fromJson(Map<String, dynamic> json)
      : idartikel = json['id_artikel'],
        judulartikel = json['judul_artikel'],
        isiartikel = json['isi_artikel'],
        gambarartikel = json['gambar_artikel'];

  Map<String, dynamic> toJson() => {
        'id_artikel': idartikel,
        'judul_artikel': judulartikel,
        'isi_artikel': isiartikel,
        'gambar_artikel': gambarartikel,
      };
}
