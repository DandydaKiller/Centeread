class DetailHadistM {
  final int idhadist;
  final String hadist;
  final int urutanhadist;
  final String artihadist;
  final int hadistbukuid;

  final String judulbukuhadist;
  final String riwayatoleh;
  /* final String riwayatoleh;
  final String tahunriwayat;
  final String cover;*/

  DetailHadistM(this.idhadist, this.hadist, this.urutanhadist, this.artihadist,
      this.hadistbukuid, this.judulbukuhadist, this.riwayatoleh);

  DetailHadistM.fromJson(Map<String, dynamic> json)
      : idhadist = json['id_surah'],
        hadist = json['hadist'],
        urutanhadist = json['urutan_hadist'],
        artihadist = json['arti_hadist'],
        hadistbukuid = json['urutan_ayat'],
        judulbukuhadist = json['judul_buku_hadist'],
        riwayatoleh = json['riwayat_oleh'];

  Map<String, dynamic> toJson() => {
        'id_hadist': idhadist,
        'hadist': hadist,
        'urutan_hadist': urutanhadist,
        'arti_hadist': artihadist,
        'hadist_buku_id': hadistbukuid,
        'judul_buku_hadist': judulbukuhadist,
        'riwayat_oleh': riwayatoleh,
      };
}
