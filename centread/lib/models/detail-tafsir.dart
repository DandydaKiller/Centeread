class DetailTafsirM {
  final int idtafsir;
  final int idpenafsir;
  final String namapenafsir;
  final String tahunditafsirkan;

  final int idsurah;
  final String namasurah;
  final int jumlahayat;
  final String turundi;
  final int urutansurah;
  final String lafadz;
  final String artisurah;

  DetailTafsirM(
      this.idtafsir,
      this.idpenafsir,
      this.namapenafsir,
      this.tahunditafsirkan,
      this.idsurah,
      this.namasurah,
      this.jumlahayat,
      this.turundi,
      this.urutansurah,
      this.lafadz,
      this.artisurah);

  DetailTafsirM.fromJson(Map<String, dynamic> json)
      : idtafsir = json['id_tafsir'],
        idpenafsir = json['id_penafsir'],
        namapenafsir = json['nama_penafsir'],
        tahunditafsirkan = json['tahun_ditafsirkan'],
        idsurah = json['id_surah'],
        namasurah = json['nama_surah'],
        jumlahayat = json['jumlah_ayat'],
        turundi = json['turun_di'],
        urutansurah = json['urutan_surah'],
        lafadz = json['lafadz'],
        artisurah = json['arti_surah'];

  Map<String, dynamic> toJson() => {
        'id_tafsir': idtafsir,
        'id_penafsir': idpenafsir,
        'nama_penafsir': namapenafsir,
        'tahun_ditafsirkan': tahunditafsirkan,
        'id_surah': idsurah,
        'nama_surah': namasurah,
        'jumlah_ayat': jumlahayat,
        'turun_di': turundi,
        'urutan_surah': urutansurah,
        'lafadz': lafadz,
        'arti_surah': artisurah
      };
}
