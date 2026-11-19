# Diagram Integrasi Data: Tugas 10

Alur ini berlaku untuk satu kali pemuatan halaman daftar laporan SiLapor Kampus.

## 1. Alur Request, Parsing, dan Penyajian

```mermaid
flowchart TD
    A[Halaman daftar laporan] -->|ambilDataTerintegrasi| B[IntegrasiService]
    B --> C[Future.wait]
    C -->|GET /users| D[ambilPengguna]
    C -->|GET /posts| E[ambilLaporan]
    D -->|jsonDecode lalu fromJson| F[List DataPengguna]
    E -->|jsonDecode lalu fromJson| G[List DataLaporan]
    F --> H[Peta id ke nama]
    G --> I[Gabung per laporan]
    H --> I
    I -->|userId sama dengan id pengguna| J[List LaporanRingkas]
    J --> A
    D -.->|gagal| K[ApiException]
    E -.->|gagal| K
    K -.-> A
```

Garis putus adalah jalur gagal. Service mengubah semua kegagalan menjadi `ApiException`, dan halaman cukup menangkap satu tipe itu.

## 2. Urutan Request dan Response

```mermaid
sequenceDiagram
    participant H as Halaman
    participant S as IntegrasiService
    participant U as GET /users
    participant L as GET /posts

    H->>S: ambilDataTerintegrasi()
    par dijalankan bersamaan
        S->>U: request
        S->>L: request (_limit=20)
    end
    U-->>S: 200, array pengguna
    L-->>S: 200, array laporan
    S->>S: cek status, jsonDecode, fromJson
    S->>S: cocokkan userId dengan id pengguna
    S-->>H: List LaporanRingkas
    H->>H: setState, tampilkan daftar
```

## 3. Kondisi Halaman

```mermaid
stateDiagram-v2
    [*] --> Loading
    Loading --> Data: sukses, list tidak kosong
    Loading --> Kosong: sukses, list kosong
    Loading --> Error: ApiException
    Error --> Loading: tombol Coba Lagi
    Kosong --> Loading: tombol Muat Ulang
    Data --> Loading: tarik untuk muat ulang
```

Kondisi Kosong dipisahkan dari Error karena request-nya berhasil. Pesan error pada daftar yang memang kosong akan menyesatkan petugas dan mendorong percobaan ulang yang tidak ada gunanya.
