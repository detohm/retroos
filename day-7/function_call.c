int callee_function(int arg) {
  arg++;
  return arg;
}

void caller_function() {
  callee_function(0xface);
}

