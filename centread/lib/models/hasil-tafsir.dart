class HasilTafsirM {
  final int idtafsir;
  final String namasurah;
  final int ayat;
  final String tafsir;

  HasilTafsirM(this.idtafsir, this.namasurah, this.ayat, this.tafsir);

  HasilTafsirM.fromJson(Map<String, dynamic> json)
      : idtafsir = json['id_tafsir'],
        namasurah = json['nama_surah'],
        ayat = json['ayat'],
        tafsir = json['tafsir'];

  Map<String, dynamic> toJson() => {
        'id_tafsir': idtafsir,
        'nama_surah': namasurah,
        'ayat': ayat,
        'tafsir': tafsir
      };
}
