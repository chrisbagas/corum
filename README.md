# C08
[![Flutter CI/CD](https://github.com/chrisbagas/corum/actions/workflows/main.yml/badge.svg)](https://github.com/chrisbagas/corum/actions/workflows/main.yml)
## Nama Website: Corum
## Link: https://corum.herokuapp.com/ 
## Link Apk: https://github.com/chrisbagas/corum/releases/latest
## Pengembang:
1. Ahmad Rafi Wirana - 2006595873
2. Andhira Henrisen Sikoko - 2006596296
3. Christopher Bagas Laiputra - 2006595822
4. Ilhan Firka Najia - 2006596144
5. Muhammad Hafidz Sulistyanto - 2006536965
6. Vincent Yovian - 2006595816
7. Visianita Widyaningrum - 2006596610
## Story:
Platform (Website dan Mobile App) kami merupakan sarana bagi orang-orang yang ingin berbagi cerita seputar Covid-19. Baik membagikan pengalaman jika pernah terjangkit covid-19 sebelumnya, pengalaman yang dirasakan ketika melakukan vaksin, serta hal-hal apapun yang merupakan dampak dari pandemi covid ini. Selain itu, platform kami juga menyediakan forum bagi pengguna yang memiliki pertanyaan seputar covid-19 dimana pertanyaan tersebut bisa dijawab oleh pengguna lain yang sekiranya tahu atau pernah mengalami apa yang ditanyakan tersebut. Corum mobile merupakan integrasi mobile app dengan website [Corum Website](https://corum.herokuapp.com/).
## Daftar Modul:
- Sign up/Sign in<br>
Modul ini akan digunakan untuk mengidentifikasi pengguna website. Pada modul ini nanti akan dibuat model untuk data yang berisi data pengguna, yaitu nama lengkap, username/nickname, email, dan password. Modul ini akan terintegrasi dengan database django yang berasal
dari website [Corum Website](https://corum.herokuapp.com/).  Proses web service yang dilakukan ialah menngimplementasikan REST API pada views.py di Django pakai Django JSON Serializer/JsonResponse, kemudian implementasi widget Flutter sesuai desain aplikasi. Terakhir, front-end mobile app dan back-end django akan diintegrasi dengan konsep async HTTP.
- Dashboard Profil<br>
Modul ini digunakan oleh user yang sudah login untuk memodifikasi data pada profil milik user tersebut, diantaranya mencakup nama, deskripsi diri, dan menambahkan foto profil.
- Events<br>
Modul ini akan berisi daftar event-event yang akan diadakan oleh platform kami. Admin akan menambahkan event-event yang akan berlangsung di modul ini. Event-event yang diadakan memiliki tema seputar Covid-19. Event-event tersebut dapat berupa talkshow, seminar, dan lain sebagainya yang dapat diikuti oleh pengguna. Modul ini akan menampilkan informasi seperti tempat, waktu, media dan deskripsi umum event. Modul ini akan menggunakan Json Response dari backend Django Website yang akan mereturn JSON yang berisi data-data dari Event yang telah dibuat setelah mobile app mengirimkan http request ke website Corum. Selain itu, dari mobile app admin juga dapat menambahkan event baru yang akan mengirimkan asyncronus HTTP ke Django backend Corum
- Blog Content<br>
Modul ini akan menampilkan daftar blog-blog yang ada dari situs web Corum serta isi dari masing-masing blog tersebut dalam halamannya masing-masing. Daftar blog tersebut ditampilkan dalam bentuk kartu-kartu. Setiap blog diimplementasikan sebagai sebuah model yang memiliki judul, subjudul, gambar, dan isi. Saat sebuah blog ditambahkan, judul, subjudul, gambar blog, tanggal post-nya, dan nama user yang membuat blognya akan ditampilkan. Saat seorang user mengklik kartunya, isi dari blognya akan ditampilkan di dalam sebuah sub url. Untuk mewujudkan fitur-fitur tersebut, akan diimplementasikan sebuah API (*Application Programming Interface*) yang sederhana di dalam kode *back-end* Django bagian blog. API tersebut akan mampu mengembalikan data dalam bentuk JSON melalui request HTML metode GET ke jalur URL yang tepat. Kemudian di dalam aplikasi ini, sebuah fungsi asinkronus akan diimplementasikan yang dapat melakukan request tersebut untuk mengambil data yang dibutuhkan. Untuk melakukan ini, akan digunakan library http yang telah disediakan oleh Dart.
- Forum<br>
Pada modul ini akan ditampilkan kumpulan forum yang berisi diskusi antar pengguna website seputar pandemi covid. Tampilan forum ditampilkan menggunakan kumpulan Card dengan widget ListView, yang terdiri atas nama pengirim, waktu pembuatan, dan judul forum. Jika card tersebut ditekan, akan ada handling onPressed atau onClick sehingga pengguna diarahkan ke halaman yang berisi pembahasan terkait forum tersebut. Selain itu pada halaman forum terdapat juga button yang jika di-click akan muncul Form dengan TextFormField untuk membuat forum baru. Terakhir, data pada modul ini juga akan diterima dan dikirim ke Web Service Django dengan menerapkan pemanggilan _Asynchronous_.
- Mini Survey<br>
Modul ini menampilkan survei kecil-kecilan untuk mengetahui preferensi tiap pengguna terhadap sebuah isu. Pengguna yang sudah melakukan login dapat membuat survei mereka sendiri jika mereka ingin mengetahui preferensi pengguna lainnya terhadap suatu topik. Survei yang dibuat diharapkan tetap sesuai dengan tema yaitu berkaitan dengan pandemi covid-19.
Untuk mengintegrasikan website dengan Flutter pada mobile-app akan dibuat sebuah API yang dapat mengembalikan response dalam bentuk JSON dengan method GET untuk dapat menampilkan data survey yang tersimpan di dalam database website serta mengirim input dengan method POST berupa survey baru yang dibuat oleh pengguna ke URL pada django service untuk kemudian disimpan ke dalam database.
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
