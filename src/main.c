#define MODULES
#include "../config.h"

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main(void) {
  const unsigned int modules_length = sizeof(modules) / sizeof(modules[0]);
  char** module_contents = (char**) malloc(modules_length * sizeof(char*));
  if(module_contents == NULL) {
    fprintf(stderr, "malloc failed\n");
    fflush(stderr);
    return -1;
  }

  for(unsigned int i = 0; i < modules_length; i ++)
    module_contents[i] = NULL;

  unsigned int ticks = 0;
  while(1) {
    unsigned int contents_length = 0;

    bool require_update = false;
    for(unsigned int i = 0; i < modules_length; i ++) {
      if(ticks == 0 || (modules[i].update_interval != 0 && ticks % modules[i].update_interval == 0)) {
        require_update = true;
        if(module_contents[i] != NULL)
          free(module_contents[i]);

        module_contents[i] = modules[i].function(modules[i].argument);
        if(module_contents[i] == NULL) {
          fprintf(stderr, "Failed to execute module number %u with argument %s\n", i + 1, modules[i].argument);
          fflush(stderr);
          goto free_module_contents;
        }
      }

      contents_length += strlen(module_contents[i]);
    }

    if(!require_update)
      goto wait;

    char* contents = (char*) malloc((contents_length + 1) * sizeof(char));
    if(contents == NULL) {
      fprintf(stderr, "malloc failed\n");
      fflush(stderr);
      goto free_module_contents;
    }

    contents[0] = '\0';
    for(unsigned int i = 0; i < modules_length; i ++)
      strcat(contents, module_contents[i]);

    if(strstr(contents, "\n") != NULL) {
      char* output = (char*) malloc(contents_length * sizeof(char));
      if(output == NULL) {
        free(contents);
        goto free_module_contents;
      }
      output[0] = '\0';

      char* contents_pointer = contents;
      char* buffer;
      while((buffer = strsep(&contents_pointer, "\n")) != NULL)
        strcat(output, buffer);

      fprintf(stdout, OUTPUT_FORMAT, output);
      fflush(stdout);

      free(output);
    } else {
      fprintf(stdout, OUTPUT_FORMAT, contents);
      fflush(stdout);
    }

    free(contents);

wait:
    ticks ++;
    sleep(1);
  }

free_module_contents:
  for(unsigned int i = 0; module_contents[i] != NULL && i < modules_length; i ++)
    free(module_contents[i]);
  free(module_contents);
  return 0;
}
