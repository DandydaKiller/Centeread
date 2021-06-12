class TafsirM {
  final int idpenafsir;
  final String namapenafsir;
  final String tahunditafsirkan;
  final String cover;

  TafsirM(
      this.idpenafsir, this.namapenafsir, this.tahunditafsirkan, this.cover);

  TafsirM.fromJson(Map<String, dynamic> json)
      : idpenafsir = json['id_penafsir'],
        namapenafsir = json['nama_penafsir'],
        tahunditafsirkan = json['tahun_ditafsirkan'],
        cover = json['cover'];

  Map<String, dynamic> toJson() => {
        'id_penafsir': idpenafsir,
        'nama_penafsir': namapenafsir,
        'tahun_ditafsirkan': tahunditafsirkan,
        'cover': cover
      };
}
