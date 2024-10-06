#define MODULE_CONFIGS
#include "../config.h"
#include "modules.h"

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <wchar.h>

// utils
int file_length(const char* path) {
  FILE* file_pointer = fopen(path, "r");
  if(file_pointer == NULL)
    return -1;

  fseek(file_pointer, 0L, SEEK_END);
  int length = ftell(file_pointer);
  
  fclose(file_pointer);
  return length;
}

// modules
char* battery_capacity_symbol(const char* path) {
  char* battery_capacity_string = file_contents(path);
  if(battery_capacity_string == NULL)
    return NULL;

  char* end = NULL;
  float battery_capacity_float = (float)strtol(battery_capacity_string, &end, 10);

  if(strcmp(end, battery_capacity_string) == 0)
    return NULL;

  free(battery_capacity_string);

  unsigned int battery_capacity_symbols_length = sizeof(battery_capacity_symbols) / sizeof(battery_capacity_symbols[0]) - 1;

  battery_capacity_float /= BATTERY_CAPACITY_MAX;
  battery_capacity_float *= battery_capacity_symbols_length;

  return strdup(battery_capacity_symbols[(int)battery_capacity_float]);
}

char* battery_status_symbol(const char* path) {
  char* battery_status = file_contents(path);
  if(battery_status == NULL)
    return NULL;

  char* symbol = NULL;

  battery_status[strlen(battery_status) - 1] = '\0';
  if(strcmp(battery_status, "Charging") == 0)
    symbol = strdup(battery_status_symbols[0]);
  else
    symbol = strdup(battery_status_symbols[1]);

  free(battery_status);

  return symbol;
}

char* date_time(const char* format) {
  time_t raw_time = time(NULL);
  struct tm* local_time = localtime(&raw_time);

  char buffer[BUFFER_SIZE];
  unsigned int length = strftime(buffer, BUFFER_SIZE, format, local_time);
  char* output = (char*) malloc((length + 1) * sizeof(char));
  if(output == NULL)
    return NULL;

  strftime(output, length + 1, format, local_time);
  return output;
}

char* file_contents(const char* path) {
  int length = file_length(path);
  if(!length)
    return NULL;

  char* contents = (char*) malloc(length);
  if(contents == NULL)
    return NULL;
  contents[0] = '\0';

  FILE* file_pointer = fopen(path, "r");
  if(file_pointer == NULL) {
    free(contents);
    return NULL;
  }

  char buffer[256] = "";
  while(fgets(buffer, 256, file_pointer) != NULL)
    strcat(contents, buffer);
  fclose(file_pointer);

  return contents;
}

char* hour_symbol(const char* unused) {
  time_t raw_time = time(NULL);
  struct tm* local_time = localtime(&raw_time);

  unsigned int hour_symbols_length = sizeof(hour_symbols) / sizeof(hour_symbols[0]) - 1;
  float hour = (float) local_time->tm_hour / 24 * hour_symbols_length;

  return strdup(hour_symbols[(int) hour]);
}

char* text(const char* argument) {
  return strdup(argument);
}
