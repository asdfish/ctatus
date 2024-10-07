#ifndef DEFINITIONS_H
#define DEFINITIONS_H

typedef struct {
  const char* argument;
  char* (*function) (const char* argument);
  unsigned int update_interval;
} Module;

#endif
