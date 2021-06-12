class QuranM {
  final int idsurah;
  final String namasurah;
  final int jumlahayat;
  final String turundi;
  final int urutansurah;
  final String lafadz;
  final String artisurah;

  QuranM(this.idsurah, this.namasurah, this.jumlahayat, this.turundi,
      this.urutansurah, this.lafadz, this.artisurah);

  QuranM.fromJson(Map<String, dynamic> json)
      : idsurah = json['id_surah'],
        namasurah = json['nama_surah'],
        jumlahayat = json['jumlah_ayat'],
        turundi = json['turun_di'],
        urutansurah = json['urutan_surah'],
        lafadz = json['lafadz'],
        artisurah = json['arti_surah'];

  Map<String, dynamic> toJson() => {
        'id_surah': idsurah,
        'nama_surah': namasurah,
        'jumlah_ayat': jumlahayat,
        'turun_di': turundi,
        'urutan_surah': urutansurah,
        'lafadz': lafadz,
        'arti_surah': artisurah
      };
}
