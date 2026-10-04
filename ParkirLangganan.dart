double hitungTarifProgresif(int jamParkir) {
  if (jamParkir <= 1) {
    return 2000;
  }
  if (jamParkir <= 3) {
    return 2000 + (jamParkir - 1) * 3000;
  }
  return 2000 + 2 * 3000 + (jamParkir - 3) * 5000;
}

double hitungTarifParkir(int jamParkir, bool member) {
  if (member == true) {
    return 0;
  }
  return hitungTarifProgresif(jamParkir);
}

double hitungDenda(bool tiketHilang) {
  if (tiketHilang == true) {
    return 20000;
  }
  return 0;
}

double hitungTotalBayar(int jamParkir, bool member, bool tiketHilang) {
  double tarif = hitungTarifParkir(jamParkir, member);
  double denda = hitungDenda(tiketHilang);

  double totalBayar = tarif + denda;

  return totalBayar;
}

void main() {
  print(hitungTotalBayar(1, false, false));
  print(hitungTotalBayar(3, false, false));
  print(hitungTotalBayar(6, false, false));
  print(hitungTotalBayar(5, true, false));
  print(hitungTotalBayar(2, false, true));
  print(hitungTotalBayar(4, true, true));
}
