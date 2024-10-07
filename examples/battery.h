#pragma once
#include <definitions.h>
#include <modules.h>

// if you get an error saying "stack smashing detected", increase this number
#define BUFFER_SIZE 256

// some bars/wm require newlines in order to be reach, such as waybar or lemonbar
#define OUTPUT_FORMAT "%s\n"

#ifdef MODULES
static Module modules[] = {
  {
    "| ",
    text,
    0
  },
  {
    "/sys/class/power_supply/BAT0/capacity",
    battery_capacity_symbol,
    15,
  },
  {
    " ",
    text,
    0,
  },
  {
    "/sys/class/power_supply/BAT0/capacity",
    file_contents,
    15,
  },
  {
    " ",
    text,
    0,
  },
  {
    "/sys/class/power_supply/BAT0/status",
    battery_status_symbol,
    15,
  },
  {
    " | ",
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
