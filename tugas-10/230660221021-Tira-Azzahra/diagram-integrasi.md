# Diagram Alur Integrasi Data — SI Perpustakaan Kampus

```mermaid
flowchart LR
    UI[HalamanPeminjamanTerintegrasi] -->|1. Panggil service| SVC[PerpustakaanService]
    SVC -->|2. Future.wait| API1[GET /users - Data Anggota]
    SVC -->|2. Future.wait| API2[GET /posts - Pengajuan Buku]
    API1 -->|3. JSON Parsing| M1[List AnggotaPerpustakaan]
    API2 -->|3. JSON Parsing| M2[List PengajuanBuku]
    M1 & M2 -->|4. Gabung via userId| VM[List PeminjamanRingkas]
    VM -->|5. setState UI| UI