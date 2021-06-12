class BukuHadistM {
  final int idbukuhadist;
  final String judulbukuhadist;
  final String riwayatoleh;
  final String tahunriwayat;
  final String cover;

  BukuHadistM(this.idbukuhadist, this.judulbukuhadist, this.riwayatoleh,
      this.tahunriwayat, this.cover);

  BukuHadistM.fromJson(Map<String, dynamic> json)
      : idbukuhadist = json['id_buku_hadist'],
        judulbukuhadist = json['judul_buku_hadist'],
        riwayatoleh = json['riwayat_oleh'],
        tahunriwayat = json['tahun_riwayat'],
        cover = json['cover'];

  Map<String, dynamic> toJson() => {
        'id_surah': idbukuhadist,
        'judul_buku_hadist': judulbukuhadist,
        'riwayat_oleh': riwayatoleh,
        'tahun_riwayat': tahunriwayat,
        'cover': cover,
      };
}
