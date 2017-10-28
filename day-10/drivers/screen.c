#include "screen.h"
#include "port.h"

int get_screen_offset (int col, int row) {
  return 2 * (row * MAX_COLS + col);
}

int get_offset_row(int offset){
  return offset / (2 * MAX_COLS);
}

int get_offset_col(int offset){
  return (offset - (get_offset_row(offset)*2*MAX_COLS))/2;
}


int get_cursor_offset(){
  port_byte_out(REG_SCREEN_CTRL,14);
  int offset = port_byte_in(REG_SCREEN_DATA) << 8;
  port_byte_out(REG_SCREEN_CTRL,15);
  offset += port_byte_in(REG_SCREEN_DATA);

  return offset * 2;

}

void set_cursor_offset(int offset){
  offset /= 2;
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
  port_byte_out(REG_SCREEN_CTRL, 15);
  // SHAME RECORDED - spent 3 hours for debuging why the cursor was not moved...
  // found used && (logical op) instead of & (bit AND op) so it kept set the cursor position to 1 (true). T.T
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset & 0xff));


}

int print_char (char character, int col, int row, char attribute_byte) {
  unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;
  if (!attribute_byte){
    attribute_byte = WHITE_ON_BLACK;
  }

  int offset;

  if (col >=0 && row >= 0) {
    offset = get_screen_offset(col,row);
  }else{
    offset = get_cursor_offset();
  }

  if(character == '\n'){
    int rows = offset / (2 * MAX_COLS);
    offset = get_screen_offset(79, rows);

  } else {
    vidmem[offset] = character;
    vidmem[offset+1] = attribute_byte;
    offset += 2;
  }


  //offset = handle_scrolling(offset);
  set_cursor_offset(offset);
  return offset;
}

void print_at (char* message, int col, int row) {

  int offset;

  if (col >=0 && row >= 0){
    offset = get_screen_offset(col,row);
  }else{
    offset = get_cursor_offset();
    row = get_offset_row(offset);
    col = get_offset_col(offset);

  }

  int i = 0;
  while(message[i] != 0) {
    offset = print_char(message[i++],col,row,WHITE_ON_BLACK);
    row = get_offset_row(offset);
    col = get_offset_col(offset);
  }

  set_cursor_offset(offset);
}

void print(char* message){
  print_at(message, -1, -1);
}

void clear_screen(){
  int row = 0;
  int col = 0;

  for (row = 0;row<MAX_ROWS; row++){
    for(col = 0; col<MAX_COLS; col++){
      print_char(' ',col,row, WHITE_ON_BLACK);

    }
  }

  set_cursor_offset(get_screen_offset(0,0));
}


