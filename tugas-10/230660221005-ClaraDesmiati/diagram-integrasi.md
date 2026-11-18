# Diagram Integrasi Data SIAngkut

## Alur Request dan Response

```mermaid
flowchart TD
    A([Mulai]) --> B[Halaman Integrasi]
    B --> C[IntegrasiService]
    C --> D[GET /users]
    C --> E[GET /posts?_limit=10]
    D --> F[Future.wait]
    E --> F
    F --> G{Kedua request berhasil?}
    G -- Tidak --> H[Tampilkan Error]
    H --> I[Tombol Coba Lagi]
    I --> C
    G -- Ya --> J[Parsing JSON ke Model Dart]
    J --> K[DataPengguna dan DataPengajuan]
    K --> L[Gabungkan berdasarkan userId]
    L --> M{Data tersedia?}
    M -- Tidak --> N[Tampilkan Kondisi Kosong]
    M -- Ya --> O[Tampilkan Daftar Laporan]
    O --> P([Selesai])
    N --> P
```

## Alur POST

```mermaid
flowchart TD
    A([Mulai]) --> B[Data Pengajuan Baru]
    B --> C[POST /posts]
    C --> D{Status HTTP 201?}
    D -- Ya --> E[Parsing Response JSON]
    E --> F[DataPengajuan]
    D -- Tidak --> G[Penanganan Error]
    F --> H([Selesai])
    G --> H
```

## Penjelasan

1. Halaman meminta data melalui IntegrasiService.
2. Service menjalankan dua request GET menggunakan Future.wait.
3. Respons JSON diubah menjadi model DataPengguna dan DataPengajuan.
4. Data digabungkan menggunakan userId sebagai identifier.
5. Hasil gabungan dikirim ke halaman untuk ditampilkan.
6. Jika terjadi kegagalan, halaman menyediakan tombol Coba Lagi.
7. POST digunakan untuk simulasi pengiriman pengajuan baru.
