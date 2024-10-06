#pragma once
#include "src/definitions.h"
#include "src/modules.h"

// some bars/wm require newlines in order to be reach, such as waybar or lemonbar
#define OUTPUT_FORMAT "%s\n"

#ifdef MODULES
static Module modules[] = {
  {
    "| ",
    text,
    0,
  },
  {
    "",
    hour_symbol,
    900
  },
  {
    " %H:%M",
    date_time,
    15,
  },
  {
    " |  ",
    text,
    0
  },
  {
    "%a %d %b %Y ",
    date_time,
    0
  }
};
#endif

#ifdef MODULE_CONFIGS
// some computers don't report 100 as max
#define BATTERY_CAPACITY_MAX 100
static const char* battery_capacity_symbols[] = {
  "󰂎",
  "󰁺",
  "󰁻",
  "󰁼",
  "󰁽",
  "󰁾",
  "󰁿",
  "󰂀",
  "󰂁",
  "󰂂",
  "󱟢"
};

static const char* battery_status_symbols[] = {
  "", // Charging
  "", // Discharging
};

static const char* hour_symbols[] = {
  "󱑊",
  "󱐿",
  "󱑀",
  "󱑁",
  "󱑂",
  "󱑃",
  "󱑄",
  "󱑅",
  "󱑆",
  "󱑇",
  "󱑈",
  "󱑉",
  "󱑖",
  "󱑋",
  "󱑌",
  "󱑍",
  "󱑎",
  "󱑏",
  "󱑐",
  "󱑑",
  "󱑒",
  "󱑓",
  "󱑔",
  "󱑕",
};
#endif
