# Information Architecture — Perpustakaan Kampus

## Inventaris Layar (dari pemetaan Tugas 4)
| Layar | Kebutuhan |
|:--|:--|
| Katalog Buku (Utama) | F-01, F-02 |
| Detail Buku | F-03 |
| Form Pinjam/Reservasi | F-04 |
| Riwayat Peminjaman | F-05 |
| Pengaturan Pengingat | F-06 |

## Diagram IA
```mermaid
flowchart TD
  A["Katalog Buku (Utama)<br/>F-01, F-02"] --> B["Detail Buku<br/>F-03"]
  B --> C["Form Pinjam/Reservasi<br/>F-04"]
  A --> D["Riwayat Peminjaman<br/>F-05"]
  D --> E["Pengaturan Pengingat<br/>F-06"]