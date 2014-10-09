
var n = 1;
search: while (true) {
  n += 1;
  if (n % 1000000 == 0) {
    postMessage(n);
  }
}