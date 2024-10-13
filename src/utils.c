#include "include/utils.h"

laser_opts laser_utils_parsecmd(int argc, char **argv)
{
    int show_all = 0;
    char *dir = ".";

    int opt;

    while ((opt = getopt(argc, argv, "a")) != -1)
    {
        switch (opt)
        {
            case 'a':
                show_all = 1;
                break;
            default:
                exit(1);
        }
    }

    if (optind < argc)
        dir = argv[optind];

    return (laser_opts){show_all, dir};
}

void format_date(time_t time, char *buffer, size_t buffer_size)
{
    struct tm *tm_info = localtime(&time);
    strftime(buffer, buffer_size, "%d-%m-%Y", tm_info);
}
