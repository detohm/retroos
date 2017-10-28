#include "../drivers/screen.h"

void some_useless_function() {

}


void main() {
  // char* video_memory = (char*) 0xb8000;
  // *video_memory = 'X';
  clear_screen();
  print("Hello");
}
