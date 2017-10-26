// Distributed with a free-will license.
// Use it any way you want, profit or free, provided it fits in the licenses of its associated works.
// SHT30
// This code is designed to work with the SHT30_I2CS I2C Mini Module available from ControlEverything.com.
// https://www.controleverything.com/content/Humidity?sku=SHT30_I2CS#tabs-0-product_tabset-2

#include <stdio.h>
#include <stdlib.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <fcntl.h>

void main()
{
	// Create I2C bus
	int file;
	char *bus = "/dev/i2c-1";
	if ((file = open(bus, O_RDWR)) < 0)
	{
		printf("Failed to open the bus. \n");
		exit(1);
	}
	// Get I2C device, SHT30 I2C address is 0x44(68)
	ioctl(file, I2C_SLAVE, 0x45);

	// Send measurement command(0x2C)
	// High repeatability measurement(0x06)
  int command = 0x2c06;

	char config[2] = {0};
	// config[0] = 0x2C; // Clock stretching
  config[0] = (command >> 8) & 0xff;
	config[1] = command & 0xff;
  printf("Command 0: 0x%02x\n", config[0]);
  printf("Command 1: 0x%02x\n", config[1]);

	write(file, config, 2);
	// usleep(5000);
  sleep(1);

	// Read 6 bytes of data
	// Temp msb, Temp lsb, Temp CRC, Humididty msb, Humidity lsb, Humidity CRC
	char data[6] = {0};
	if(read(file, data, 6) != 6)
	{
		printf("Error : Input/output Error \n");
	}
	else
	{
		// Convert the data
		int temp = (data[0] << 8 | data[1]);
    printf("Field 1: 0x%02x\n", data[0]);
    printf("Field 2: 0x%02x\n", data[1]);
    printf("Field 3: 0x%02x\n", data[2]);
    printf("Field 4: 0x%02x\n", data[3]);
    printf("Field 5: 0x%02x\n", data[4]);
    printf("Field 6: 0x%02x\n", data[5]);

    printf("Temp: %i\n", temp);
    // int temp = (data[1] * 256 + data[0]);

		float cTemp = -45 + (175 * temp / 65535.0);
		float fTemp = -49 + (315 * temp / 65535.0);
		float humidity = 100 * (data[3] * 256 + data[4]) / 65535.0;

		// Output data to screen
		printf("Relative Humidity : %.2f RH \n", humidity);
		printf("Temperature in Celsius : %.2f C \n", cTemp);
		printf("Temperature in Fahrenheit : %.2f F \n", fTemp);
	}
}
