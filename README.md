# cryptoSignalProcessing
<p>Tujuan dari program ini adalah untuk melakukan analisis korelasi antara beberapa cryptocurrency pada siklus mingguan dan bulanan. Satuan Hz dalam bentuk siklus/hari</p>

<hr>

<h2>modularUAS.m</h2>
<p>Program utama berada pada file ```modularUAS.m```. Terdapat file-file yang diimport, lalu dimasukkan ke dalam sebuah array. spesifikasi seluruh filter dimasukkan juga ke dalam satu array sehingga mempermudah modularitas kode. Order dari filter akan sebesar 256.</p>
<p>Plotting, filter design, dan filtering akan dilakukan menggunakan function. Setelah dilakukan filtering, signal akan dilakukan cross-correlation</p>

<hr>

<h2>plotData.m</h2>
<p>Data dimasukkan ke dalam sebuah variabel dengan readtable. Null value pada dataset akan diisi dengan fillmissing() metode linear, lalu data diplotting dengan sumbu x sebagai waktu dengan resolusi 1 hari, y sebagai harga</p>
<p>FFT dilakukan dengan 2048-point</p>
<p>Function parameters:</p>
<ul>
  <li>filename     -> data table cryptocurrency</li>
  <li>fs           -> sampling frequency</li>
  <li>titlePrefix  -> judul dari data</li>
</ul>
<p>Function return:</p>
<ul>
  <li>price -> data closing</li>
  <li>date  -> tanggal</li>
</ul>

<hr>

<h2>designFilter.m</h2>
<p>Filter yang dibuat merupakan BP filter FIR dengan window method chebyshev. Frequency response akan diplotting dan bandpass filter dikembalikan ke main function</p>
<p>Function parameters:</p>
<ul>
  <li>f1        -> lower cutoff frequency</li>
  <li>f2        -> higher cutoff frequency</li>
  <li>fs        -> sampling frequency</li>
  <li>n         -> order of filter</li>
  <li>plotTitle -> judul plot</li>
</ul>
<p>Function return:</p>
<ul>
  <li>b -> BP filter</li>
</ul>

<hr>

<h2>applyFilter.m</h2>
<p>filtfilt digunakan untuk melakukan filtering terhadap signal dengan filter yang telah ditentukan. Setelah signal difilter, time dan frequency domain dari signal diplotting.</p>
<p>Function parameters:</p>
<ul>
  <li>price       -> y-input signal</li>
  <li>date        -> x-input signal</li>
  <li>b           -> filter</li>
  <li>fs          -> sampling frequency</li>
  <li>titlePrefix -> judul plot</li>
  <li>filterLabel -> judul filter</li>
</ul>
<p>Function return:</p>
<ul>
  <li>b -> BP filter</li>
</ul>
