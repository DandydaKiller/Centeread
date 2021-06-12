class DetailQuranM {
  final int idsurah;
  final String namasurah;
  final int jumlahayat;
  final String turundi;
  final String urutanayat;
  final String lafadz;
  final String artisurah;

  final int idayat;
  final String ayat;
  final String artiayat;

  DetailQuranM(
      this.idsurah,
      this.namasurah,
      this.jumlahayat,
      this.turundi,
      this.urutanayat,
      this.lafadz,
      this.artisurah,
      this.idayat,
      this.ayat,
      this.artiayat);

  DetailQuranM.fromJson(Map<String, dynamic> json)
      : idsurah = json['id_surah'],
        namasurah = json['nama_surah'],
        jumlahayat = json['jumlah_ayat'],
        turundi = json['turun_di'],
        urutanayat = json['urutan_ayat'],
        lafadz = json['lafadz'],
        artisurah = json['arti_surah'],
        idayat = json['id_ayat'],
        ayat = json['ayat'],
        artiayat = json['arti_ayat'];

  Map<String, dynamic> toJson() => {
        'id_surah': idsurah,
        'nama_surah': namasurah,
        'jumlah_ayat': jumlahayat,
        'turun_di': turundi,
        'urutan_ayat': urutanayat,
        'lafadz': lafadz,
        'arti_surah': artisurah,
        'id_ayat': idayat,
        'ayat': ayat,
        'arti_ayat': artiayat
      };
}
