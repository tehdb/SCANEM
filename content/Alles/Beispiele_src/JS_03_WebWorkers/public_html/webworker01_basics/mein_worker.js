
var n = 1;
//search: while (true) {
search: while (n < 100000) {
  n += 1;
  for (var i = 2; i <= Math.sqrt(n); i += 1)
    if (n % i == 0)
     continue search;
  // Primzahl gefunden!
  postMessage(n);
}