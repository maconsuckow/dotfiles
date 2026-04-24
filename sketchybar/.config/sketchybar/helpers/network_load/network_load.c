#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// Simple network load helper for sketchybar
// Usage: network_load <interface> <update_interval> <event_name>

int main(int argc, char** argv) {
  if (argc < 4) {
    printf("Usage: %s <interface> <update_interval> <event_name>\n", argv[0]);
    return 1;
  }

  char* interface = argv[1];
  int interval = atoi(argv[2]);
  char* event_name = argv[3];

  unsigned long long last_ibytes = 0;
  unsigned long long last_obytes = 0;

  char command[256];
  sprintf(command, "netstat -ibn -I %s | awk '/Link/ {print $7, $10}'", interface);

  while (1) {
    FILE* fp = popen(command, "r");
    if (fp) {
      unsigned long long ibytes = 0;
      unsigned long long obytes = 0;
      if (fscanf(fp, "%llu %llu", &ibytes, &obytes) == 2) {
        if (last_ibytes > 0 && last_obytes > 0) {
          double up = (obytes - last_obytes) / (double)interval;
          double down = (ibytes - last_ibytes) / (double)interval;

          char up_str[32], down_str[32];
          if (up > 1048576) sprintf(up_str, "%.1f MB/s", up / 1048576.0);
          else if (up > 1024) sprintf(up_str, "%.1f KB/s", up / 1024.0);
          else sprintf(up_str, "%llu B/s", (unsigned long long)up);

          if (down > 1048576) sprintf(down_str, "%.1f MB/s", down / 1048576.0);
          else if (down > 1024) sprintf(down_str, "%.1f KB/s", down / 1024.0);
          else sprintf(down_str, "%llu B/s", (unsigned long long)down);

          char trigger[512];
          sprintf(trigger, "sketchybar --trigger %s upload=\"%s\" download=\"%s\"", event_name, up_str, down_str);
          system(trigger);
        }
        last_ibytes = ibytes;
        last_obytes = obytes;
      }
      pclose(fp);
    }
    sleep(interval);
  }

  return 0;
}
