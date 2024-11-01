#ifndef LASER_LASER_H
#define LASER_LASER_H

#include "colors.h"
#include "utils.h"
#include "sort.h"
#include <dirent.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <errno.h>

#define MAX_ENTRIES 1024

void laser_list_directory(laser_opts opts, int depth);
void laser_print_entry(const char *name, const char *color, char *indent, int depth, int is_last);

#endif
