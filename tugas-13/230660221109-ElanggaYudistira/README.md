# Tugas 13 — Testing, Debugging, dan Perbaikan

## Identitas

- **Nama:** Elangga Yudistira
- **NIM:** 230660221109
- **Kelas:** SI-VIIA
- **Project:** MoneyTrack Mahasiswa

## Cara menjalankan

    cd C:\Users\ELANG\SI-VIIA-Mobile\tugas_13_web
    flutter pub get
    flutter analyze
    flutter test
    flutter run -d chrome

Target manual yang digunakan adalah Chrome melalui Flutter Web. Unit test memeriksa aturan validator dan regression test memeriksa helper pesan ringkas untuk form invalid.

## Perbaikan yang dilakukan

BUG-001 ditemukan ketika hasil Form.validate tidak ikut menentukan status message. Perbaikannya memindahkan aturan penyusunan pesan ke InputValidators.summary dan menambahkan assertion regression test. Perubahan ini menjaga error khusus tanggal atau file ketika field form sudah valid, serta menyediakan pesan ringkas ketika field wajib belum valid.

## Jenis testing

- Static analysis memeriksa error tipe, import, dan lint.
- Unit test memeriksa InputValidators.amount, email, requiredText, dan summary.
- Widget atau regression test pada file test memastikan bug fix memiliki expected result yang eksplisit.
- Manual functional test memeriksa form valid, input invalid, pemilihan file, dan pembatalan file chooser.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu menyusun test case, bug report, regression test, dan quiz; kode, hasil test, dan keputusan bug fix diperiksa serta diverifikasi oleh penulis.
