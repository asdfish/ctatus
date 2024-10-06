#pragma once

typedef struct {
  const char* argument;
  char* (*function) (const char* argument);
  unsigned int update_interval;
} Module;
