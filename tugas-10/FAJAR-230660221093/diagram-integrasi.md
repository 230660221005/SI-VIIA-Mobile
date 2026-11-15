# Diagram Integrasi Data — Glazent.pro

| | |
|:--|:--|
| **Nama** | Fajar |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

## 1. Alur Request dan Response

Tiga request tidak saling bergantung sehingga dijalankan bersamaan dengan `Future.wait`. Bila salah satu gagal, halaman menerima satu `ApiException` yang menyebutkan data yang gagal.

![Diagram alur request dan response](diagram-integrasi.png)

```mermaid
sequenceDiagram
    participant H as Halaman
    participant S as IntegrasiService
    participant A as API simulasi
    H->>S: ambilDataTerintegrasi()
    Note over S: Future.wait: tiga request berjalan bersamaan
    par
        S->>A: GET /users
        A-->>S: 200 + JSON pelanggan
    and
        S->>A: GET /posts?_limit=20
        A-->>S: 200 + JSON pesanan
    and
        S->>A: GET /todos?_limit=12
        A-->>S: 200 + JSON progres
    end
    S->>S: fromJson, lalu gabungkan() berdasarkan userId dan id
    S->>S: tentukanStatus() untuk setiap pesanan
    S-->>H: List PesananRingkas
    Note over H: daftar tampil, atau status kosong bila list kosong
    opt salah satu request gagal
        S-->>H: ApiException berisi pesan
        Note over H: pesan error dan tombol Coba Lagi
    end
```

## 2. Penggabungan Data Berdasarkan Identifier

```mermaid
flowchart LR
    H["Halaman<br>HalamanDaftarPesanan"] -->|"ambilDataTerintegrasi()"| S["IntegrasiService"]
    S -->|"GET /users"| U[("/users<br>pelanggan")]
    S -->|"GET /posts?_limit=20"| P[("/posts<br>pesanan")]
    S -->|"GET /todos?_limit=12"| T[("/todos<br>progres")]
    U --> MU["DataPelanggan<br>id, nama, kota"]
    P --> MP["DataPesanan<br>id, userId, layanan"]
    T --> MT["DataProgres<br>id, selesai"]
    MU -->|"pesanan.userId = pelanggan.id"| G["gabungkan()<br>+ tentukanStatus()"]
    MP --> G
    MT -->|"pesanan.id = progres.id"| G
    G --> R["List PesananRingkas"]
    R --> H
```

## 3. Aturan Proses Bisnis: Status Pesanan

Aturan ini hanya berada pada `IntegrasiService.tentukanStatus`.

```mermaid
flowchart TD
    A["Pesanan"] --> B{"Ada catatan progres?<br>pesanan.id = progres.id"}
    B -- "Tidak" --> C["menunggu"]
    B -- "Ya" --> D{"completed = true?"}
    D -- "Tidak" --> E["dijadwalkan"]
    D -- "Ya" --> F["selesai"]
```
