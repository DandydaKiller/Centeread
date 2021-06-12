class ManhajM {
  final int idmanhaj;
  final String namamanhaj;
  final String deskripsimanhaj;

  ManhajM(this.idmanhaj, this.namamanhaj, this.deskripsimanhaj);

  ManhajM.fromJson(Map<String, dynamic> json)
      : idmanhaj = json['id_manhaj'],
        namamanhaj = json['nama_manhaj'],
        deskripsimanhaj = json['deskripsi_manhaj'];

  Map<String, dynamic> toJson() => {
        'id_manhaj': idmanhaj,
        'nama_manhaj': namamanhaj,
        'deskripsi_manhaj': deskripsimanhaj,
      };
}
