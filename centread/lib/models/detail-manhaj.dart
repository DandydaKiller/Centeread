class DetailManhajM {
  final int idbukumanhaj;
  final String pengarangbuku;
  final String judulbuku;
  final String ringkasanbuku;
  final String namaManhaj;
  DetailManhajM(this.idbukumanhaj, this.pengarangbuku, this.judulbuku,
      this.ringkasanbuku, this.namaManhaj);

  DetailManhajM.fromJson(Map<String, dynamic> json)
      : idbukumanhaj = json['id_buku_manhaj'],
        pengarangbuku = json['pengarang_buku'],
        judulbuku = json['judul_buku'],
        ringkasanbuku = json['ringkasan_buku'],
        namaManhaj = json['nama_manhaj'];

  Map<String, dynamic> toJson() => {
        'id_buku_manhaj': idbukumanhaj,
        'pengarang_buku': pengarangbuku,
        'judul_buku': judulbuku,
        'ringkasan_buku': ringkasanbuku,
        'nama_manhaj': namaManhaj
      };
}
