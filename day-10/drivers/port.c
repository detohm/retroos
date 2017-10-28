unsigned char port_byte_in(unsigned short port){
  unsigned char result;
  __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
  return result;
}

unsigned char port_byte_out(unsigned short port, unsigned char data){
  unsigned char result;
  __asm__("out %%al, %%dx" : :"a" (data), "d" (port));
}

unsigned char port_word_in(unsigned short port){
  unsigned char result;
  __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
  return result;
}

unsigned char port_word_out(unsigned short port, unsigned short data){
  unsigned char result;
  __asm__("out %%al, %%dx" : :"a" (data), "d" (port));
}


