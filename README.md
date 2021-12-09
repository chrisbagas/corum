# C08
<p align="center">
    <a href="https://github.com/chrisbagas/corum/actions">
      <img alt="Tests Passing" src="https://github.com/chrisbagas/corum/workflows/Test/badge.svg" />
    </a>
</p>
## Nama Website: Corum
## Link: https://corum.herokuapp.com/ 
## Pengembang:
1. Ahmad Rafi Wirana - 2006595873
2. Andhira Henrisen Sikoko - 2006596296
3. Christopher Bagas Laiputra - 2006595822
4. Ilhan Firka Najia - 2006596144
5. Muhammad Hafidz Sulistyanto - 2006536965
6. Vincent Yovian - 2006595816
7. Visianita Widyaningrum - 2006596610
## Story:
Platform (Website) kami merupakan sarana bagi orang-orang yang ingin berbagi cerita seputar Covid-19. Baik membagikan pengalaman jika pernah terjangkit covid-19 sebelumnya, pengalaman yang dirasakan ketika melakukan vaksin, serta hal-hal apapun yang merupakan dampak dari pandemi covid ini. Selain itu, platform kami juga menyediakan forum bagi pengguna yang memiliki pertanyaan seputar covid-19 dimana pertanyaan tersebut bisa dijawab oleh pengguna lain yang sekiranya tahu atau pernah mengalami apa yang ditanyakan tersebut.
## Daftar Modul:
- Sign up/Sign in<br>
Modul ini akan digunakan untuk mengidentifikasi pengguna website. Pada modul ini nanti akan dibuat model untuk data yang berisi data pengguna, yaitu nama lengkap, username/nickname, email, dan password. Sign up / sign in form ini juga bisa menggunakan akun Google atau akun lainnya untuk memasuki website agar data terintegrasi dan akses ke website sangat mudah.
- Dashboard Profil<br>
Modul ini digunakan oleh user yang sudah login untuk memodifikasi data pada profil milik user tersebut, diantaranya mencakup nama, deskripsi diri, dan menambahkan foto profil.
- Events<br>
Modul ini akan berisi daftar event-event yang akan diadakan oleh platform kami. Admin akan menambahkan event-event yang akan berlangsung di modul ini. Event-event yang diadakan memiliki tema seputar Covid-19. Event-event tersebut dapat berupa talkshow, seminar, dan lain sebagainya yang dapat diikuti oleh pengguna. Modul ini akan menampilkan informasi seperti tempat, waktu, media dan deskripsi umum event.
- Blog Content<br>
Modul ini akan menampilkan daftar blog-blog yang ada di dalam website ini serta isi dari masing-masing blog tersebut dalam sub url-sub url yang bersangkutan. Daftar blog tersebut ditampilkan dalam bentuk kartu-kartu. Setiap blog diimplementasikan sebagai sebuah model yang memiliki judul, subjudul, gambar (opsional), dan isi. Saat sebuah blog ditambahkan, judul, subjudul, gambar blog (jika ada), tanggal post-nya, dan nama user yang membuat blognya akan ditampilkan. Saat seorang user mengklik judulnya, isi dari blognya akan ditampilkan di dalam sebuah sub url.
- Forum<br>
Modul ini akan menampilkan sebuah forum yang berisi daftar diskusi antar pengguna website seputar pandemi covid. Tampilan tiap forum berupa card, yang terdiri atas nama pengirim, waktu pembuatan, judul, dan isi forum tersebut.
- Mini Survey<br>
Modul ini menampilkan survei kecil-kecilan untuk mengetahui preferensi tiap pengguna terhadap sebuah isu. Pengguna yang sudah melakukan login dapat membuat survei mereka sendiri jika mereka ingin melihat preferensi pengguna lainnya. Survei yang dibuat diharapkan tetap sesuai dengan tema yaitu berkaitan dengan pandemi covid-19.
- Home Page<br>
Modul ini merupakan halaman utama yang akan menampilkan deskripsi singkat mengenai website corum. Modul ini juga memiliki form feedback yang dapat digunakan oleh pengguna untuk memberikan feedback terhadap website corum.
## Persona:
#### Guest User
- Mengunjungi Home page
- Mengunjungi Sign up/Sign in page
- Tidak memiliki logo profil pada navbar
- Mengunjungi detail Events
#### Signed in User
- Membuat post baru pada halaman blog
- Mengajukan pertanyaan baru pada halaman forum
- Menjawab pertanyaan pengguna lain yang berada pada halaman forum
- Mengunjungi halaman dashboard profil dan memodifikasi profil 
- Membuat survei baru pada halaman mini survey
- Menjawab survei yang tersedia pada halaman mini survey
- Mengisi form feedback pada halaman home
## Referensi:
https://kotakode.com/
