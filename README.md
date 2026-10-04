# Tugas Individu - Studi Kasus : Parkir Langganan
Nama : Rizal Hermawan <br>
NIM  : 1124160208

# Document Analysis

## Problem Statement
Membuat simulasi sistem pembayaran Parkir Langganan.

Ketentuan sistem :
* Member bulanan parkir **gratis**
* Non-member membayar **tarif progresif** (semakin lama parkir, semakin mahal tarif per jamnya)
* Jika tiket hilang, dikenakan **denda Rp. 20.000**

## Actor
Aktor yang menggunakan sistem ini adalah <strong> Pengendara (member bulanan maupun non-member) </strong>

## Input & Output
Input :
* Lama parkir (jam) : durasi kendaraan berada di area parkir
* Status member : menentukan pengendara adalah member bulanan atau bukan
* Status tiket hilang : menentukan tiket parkir hilang atau tidak

Output :
* Total bayar ditampilkan terlepas member atau non-member
* Rincian pembayaran : tarif parkir, denda tiket hilang, dan total yang harus dibayar

## Functional Requirements
Fungsi utama dalam sistem ini :
* Dapat menghitung biaya parkir
* Member bulanan tidak dikenakan tarif parkir (gratis)
* Non-member dikenakan tarif progresif berdasarkan lama parkir
* Tarif per jam semakin mahal seiring bertambahnya durasi parkir
* Mengenakan denda jika tiket hilang
* Menampilkan total bayar terlepas member, non-member, maupun tiket hilang

## Business Rule

| Kode  | Business Rule                                                                               |
|-------|---------------------------------------------------------------------------------------------|
| RB-01 | Member bulanan gratis tarif parkir                                                          |
| RB-02 | Non-member dikenakan tarif progresif (semakin lama semakin mahal)                           |
| RB-03 | Tiket hilang dikenakan denda sebesar Rp. 20.000 (dua puluh ribu), berlaku juga untuk member |

Tarif progresif non-member :
* Jam ke-1 : **Rp. 2.000**
* Jam ke-2 dan ke-3 : tambah **Rp. 3.000** per jam
* Jam ke-4 dan seterusnya : tambah **Rp. 5.000** per jam

## Decomposition
parkir
* `hitungTarifProgresif` : menghitung tarif non-member berdasarkan jam, makin lama makin mahal (RB-02)
* `hitungTarifParkir` : member gratis, non-member memakai tarif progresif (RB-01, RB-02)
* `hitungDenda` : denda Rp. 20.000 jika tiket hilang (RB-03)
* `hitungTotalBayar` : menjumlahkan tarif dan denda, lalu menampilkan hasilnya

## Pattern Recognition
Dalam sistem parkir langganan ini ada beberapa pola :
* <strong>Pengecekan kondisi</strong> : setiap pembayaran, sistem mengecek status member, durasi parkir, dan tiket hilang atau tidak.
* <strong>Tarif bertingkat</strong> : sistem menaikkan tarif per jam sesuai tingkatan durasi (jam ke-1, jam ke-2 sampai ke-3, dan jam ke-4 ke atas).
* <strong>Nominal yang bertambah</strong> : setiap ada kondisi tambahan (durasi bertambah atau tiket hilang), total yang harus dibayar ikut bertambah.

## Abstraction
parkir
* tarif
* denda
* total

Dalam sistem parkir pada umumnya, ada 3 hal yang biasanya pasti ada, yaitu :
* Tarif parkir sebagai biaya dasar berdasarkan durasi
* Denda, bisa berupa tiket hilang maupun pelanggaran lainnya. Tapi di sistem ini di set denda tiket hilang.
* Total bayar yang harus dilunasi pengendara

3 aspek ini pasti akan selalu ada di setiap sistem parkir.

## Flowchart

**a. Alur Utama**
```
                 [Start]
                    │
                    ▼
   [Input: Jam Parkir, Status Member, Tiket Hilang]
                    │
                    ▼
               <Member?>
        Ya ┌────────┴────────┐ Tidak
           ▼                 ▼
     [Tarif = 0]     [Tarif = Tarif Progresif]
           │                 │       (lihat alur b)
           └────────┬────────┘
                    ▼
            <Tiket Hilang?>
        Ya ┌────────┴────────┐ Tidak
           ▼                 ▼
  [Denda = 20.000]     [Denda = 0]
           │                 │
           └────────┬────────┘
                    ▼
     [Total Bayar = Tarif + Denda]
                    │
                    ▼
         [Tampilkan Total Bayar]
                    │
                    ▼
                [Selesai]
```

**b. Detail Tarif Progresif (khusus non-member)**
```
         [Mulai: jamParkir]
                 │
                 ▼
        <jamParkir <= 1?>
        Ya ┌──────┴──────┐ Tidak
           ▼             ▼
  [Tarif = 2.000]   <jamParkir <= 3?>
           │        Ya ┌──────┴──────┐ Tidak
           │           ▼             ▼
           │  [Tarif = 2.000 +   [Tarif = 2.000 + 6.000 +
           │   (jam - 1) x 3.000]  (jam - 3) x 5.000]
           │           │             │
           └───────────┴──────┬──────┘
                              ▼
                  [Kembalikan Tarif]
```

## Pseudocode
```
FUNCTION hitungTarifProgresif(jamParkir)
    IF jamParkir <= 1 THEN
        RETURN 2000
    END IF

    IF jamParkir <= 3 THEN
        RETURN 2000 + (jamParkir - 1) * 3000
    END IF

    RETURN 2000 + 2 * 3000 + (jamParkir - 3) * 5000
END FUNCTION

FUNCTION hitungTarifParkir(jamParkir, member)
    IF member THEN
        RETURN 0
    END IF

    RETURN hitungTarifProgresif(jamParkir)
END FUNCTION

FUNCTION hitungDenda(tiketHilang)
    IF tiketHilang THEN
        RETURN 20000
    END IF

    RETURN 0
END FUNCTION

PROCEDURE hitungTotalBayar(jamParkir, member, tiketHilang)
    tarif = hitungTarifParkir(jamParkir, member)
    denda = hitungDenda(tiketHilang)

    totalBayar = tarif + denda

    DISPLAY "Total Bayar : " + totalBayar
    RETURN totalBayar
END PROCEDURE
```

## Contoh Hasil

| Jam Parkir | Member | Tiket Hilang | Tarif  | Denda  | Total Bayar |
|------------|--------|--------------|--------|--------|-------------|
| 1          | Tidak  | Tidak        | 2.000  | 0      | 2.000       |
| 3          | Tidak  | Tidak        | 8.000  | 0      | 8.000       |
| 6          | Tidak  | Tidak        | 23.000 | 0      | 23.000      |
| 5          | Ya     | Tidak        | 0      | 0      | 0           |
| 2          | Tidak  | Ya           | 5.000  | 20.000 | 25.000      |
| 4          | Ya     | Ya           | 0      | 20.000 | 20.000      |
