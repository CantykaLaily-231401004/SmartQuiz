# SmartQuiz - Aplikasi Kuis Pilihan Berganda

- **Nama**: Cantyka Laily Sabila
- **NIM**: 231401004
- **Lab**: 1

## Informasi Aplikasi

### Nama Aplikasi
**SmartQuiz**

### Deskripsi Aplikasi
SmartQuiz adalah aplikasi kuis pilihan berganda interaktif yang dirancang untuk menguji kemampuan pengguna dalam berbagai kategori, yaitu Matematika dan Pengetahuan Umum. Aplikasi ini memiliki fitur-fitur menarik seperti:

- **Dua Kategori Kuis**: Matematika dan Pengetahuan Umum
- **Timer Countdown**: Batasan waktu 5 menit untuk menyelesaikan kuis
- **Dual Theme**: Mendukung Light Mode dan Dark Mode
- **Leaderboard System**: Sistem peringkat untuk melihat performa pemain
- **Review Jawaban**: Dapat melihat jawaban benar dan salah setelah menyelesaikan kuis

## Fitur

### 1. Splash Screen
- Animasi loading dengan logo aplikasi
- Auto-redirect ke Home Screen setelah 3 detik

### 2. Home Screen
- Input nama pengguna
- Pemilihan kategori kuis (Matematika atau Pengetahuan Umum)
- Dekorasi blob untuk estetika tampilan
- Card kategori dengan highlight kuning saat dipilih (Light Mode)
- Toggle Dark/Light Mode

### 3. Quiz Screen
- Timer countdown 5 menit
- Opsi jawaban dengan visual feedback
- Navigasi antar pertanyaan (Sebelumnya/Selanjutnya)
- Tombol Keluar dengan konfirmasi
- Alert otomatis saat waktu habis

### 4. Result Screen
- Skor akhir
- Statistik detail (Persentase, Benar, Salah)
- Tombol aksi:
    - Review Jawaban
    - Papan Peringkat
    - Kembali ke Home

### 5. Review Screen
- Menampilkan semua pertanyaan
- Indikator jawaban benar/salah
- Visual feedback dengan warna hijau (benar) dan merah (salah)

### 6. Leaderboard Screen
- Filter kategori (Semua, Matematika, Pengetahuan Umum)
- Ranking dengan badge (Gold, Silver, Bronze)
- Swipe to delete dengan konfirmasi
- Tampilan skor dan tanggal

## Credit & Referensi

### Design Inspiration
- [Figma - Quiz App UI Design](https://www.figma.com/design/it2QkYi29MAPRnP1Csrm1L/Quiz-App-UI-Design--Community-?m=auto&t=voLrVwpAyPkYNyCX-6)
- [Dribbble - Quiz App Design](https://dribbble.com/tags/quiz-app)

### Assets
- **Fonts**:
    - [Poppins](https://fonts.google.com/specimen/Poppins) - Google Fonts

### Illustrations
- Custom illustrations: [Card Illustrations](https://www.freepik.com/)
- Icon pack: [Material Design Icons](https://material.io/resources/icons/)

### Color Palette
- Primary: #4A70A9 (Blue)
- Secondary: #0E469A (Dark Blue)
- Accent: #FFCE31 (Yellow)
- Success: #06B214 (Green)
- Error: #A02525 (Red)

### References
- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Material Design Guidelines](https://material.io/design)

## Video Demo
[Link Video Demo Aplikasi](https://drive.google.com/file/d/1zt0XAF2uCbZfSvDvvE_Z4fnJAYyHkAhu/view?usp=sharing)

## Mockup/Prototype
[Link Figma Mockup](https://www.figma.com/design/PWkd7GXr9rph9aVtebApKz/Pemob-Lab?node-id=69-509&t=djof6TG6EUp93Osy-1)

## Cara Menjalankan Aplikasi

1. Clone repository:
```bash
git clone https://github.com/username/smartquiz.git
```

2. Masuk ke direktori project:
```bash
cd smartquiz
```

3. Install dependencies:
```bash
flutter pub get
```

4. Jalankan aplikasi:
```bash
flutter run
```
