#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// CPU load helper for sketchybar
// Usage: cpu_load <event_name> <update_freq>

int main(int argc, char** argv) {
  if (argc < 3) {
    printf("Usage: %s <event_name> <update_freq>\n", argv[0]);
    return 1;
  }

  char* event_name = argv[1];
  float update_freq = atof(argv[2]);

  host_cpu_load_info_data_t prev_load;
  mach_msg_type_number_t count = HOST_CPU_LOAD_INFO_COUNT;
  
  if (host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&prev_load, &count) != KERN_SUCCESS) {
    fprintf(stderr, "Failed to get host statistics\n");
    return 1;
  }

  while (1) {
    usleep(update_freq * 1000000);

    host_cpu_load_info_data_t load;
    if (host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&load, &count) != KERN_SUCCESS) {
      continue;
    }

    unsigned long long user = load.cpu_ticks[CPU_STATE_USER] - prev_load.cpu_ticks[CPU_STATE_USER];
    unsigned long long sys = load.cpu_ticks[CPU_STATE_SYSTEM] - prev_load.cpu_ticks[CPU_STATE_SYSTEM];
    unsigned long long nice = load.cpu_ticks[CPU_STATE_NICE] - prev_load.cpu_ticks[CPU_STATE_NICE];
    unsigned long long idle = load.cpu_ticks[CPU_STATE_IDLE] - prev_load.cpu_ticks[CPU_STATE_IDLE];

    unsigned long long total = user + sys + nice + idle;
    if (total == 0) total = 1;

    int user_load = (int)((user + nice) * 100.0 / total);
    int sys_load = (int)(sys * 100.0 / total);
    int total_load = user_load + sys_load;

    char trigger[512];
    sprintf(trigger, "sketchybar --trigger %s user_load=\"%d%%\" total_load=\"%d%%\"", event_name, user_load, total_load);
    system(trigger);

    prev_load = load;
  }

  return 0;
}
