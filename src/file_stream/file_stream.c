#include "file_stream.h"
#include <stdio.h>

void test()
{
  printf("Hello file stream test\n");
}

void file_stream_read()
{
  FILE *fp = fopen("sensor_data/sample_csv.csv", "r");
  char buf[1024];

  if(!fp)
  {
    printf("Cannot open file\n");
    return;
  }
  
  while(fgets(buf,1024,fp))
  {
    printf("%s\n", buf);
  }

  fclose(fp);
}