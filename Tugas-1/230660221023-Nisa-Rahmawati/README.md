# Tugas 1 — Identifikasi Kebutuhan Aplikasi Bergerak
**Domain:** Sistem Informasi Absensi Kampus  
**Nama:** Nisa Rahmawati  
**NIM:** 230660221023  
**Kelas:** SI-VIIB / SI-VIIA  

---

## 1. Deskripsi Sistem
Aplikasi Sistem Informasi Absensi Kampus dikembangkan untuk memodernisasi proses pencatatan kehadiran mahasiswa dan dosen dalam perkuliahan. Masalah utama pada sistem konvensional adalah pemborosan waktu akibat pemanggilan nama secara manual, risiko kecurangan titip absen, serta keterlambatan rekapitulasi data. Solusi ini diimplementasikan dalam bentuk **aplikasi mobile** karena memanfaatkan *konteks bergerak* (pengguna berpindah antar ruang kelas) serta *pemanfaatan kapabilitas perangkat* seperti sensor GPS dan kamera (untuk validasi radius kelas dan pemindaian QR Code) yang tidak dapat dijalankan secara fleksibel melalui web desktop.

---

## 2. Diagram Arsitektur

```mermaid
flowchart LR
    A["📱 Aplikasi Mobile<br>(Flutter)"] -->|"1. HTTP Request (JSON + GPS/QR)"| B["🖥️ REST API<br>(Backend SI Absensi)"]
    B -->|"2. Validasi Jadwal & Lokasi"| C[("🗄️ Database Absensi")]
    C -->|"3. Simpan Status Kehadiran"| B
    B -->|"4. HTTP Response (Status Absen)"| A