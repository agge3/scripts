/* xxx needs to be tested, but without is fine for now */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define BUF_SIZE 1024
#define STR_SIZE 128

// Function to check if a character is a valid part of a floating-point number.
int is_float_char(char c)
{
    return isdigit(c) || c == '.' || c == '-';
}

int main()
{
	FILE *fh = fopen("/etc/issue", "r");
	if (!fh) {
	    perror("Failed to open /etc/issue");
	    return EXIT_FAILURE;
	}
	
	char buf[BUF_SIZE];
	while (fgets(buf, BUF_SIZE, fh)) {
		char *ptr = buf;
		while (*ptr) {
			if (!is_float_char(*ptr)) {
			    ptr++;
			    continue;
			}
		
			// Try to extract a floating-point number.
			char *end;
			// xxx can be int or float
			float val = strtof(ptr, &end);

			// Assign agetty color code, based on what the value is.
			char* color;
			if (val <= 40.f) {
				color = "{green}";
			} else if (value <= 60.f) {
				color = "{yellow}";
			} else {
				color = "{red}";
			}
			
			// Check if a degree or percent sign follows.
			if (*end == '°' || *end == '%') {
				printf("Found: %.2f%c\n", val, *end);

				// Setup constructing new string.
				char* ebegin = "\\e";
				char* eend = "\\e{reset}";
				char s[STR_SIZE];

				if (*end == '°') {
					// Account for 'C' or 'F' after temperature format.
					c = end + 1;
					snprintf(s, STR_SIZE, "%s%s%.2f%c%c%s", ebegin, color, val, *end, *c, eend);
					end = c; // set end to the proper end of our capture
				} else {
					snprintf(s, STR_SIZE, "%s%s%.2f%c%s", ebegin, color, val, *end, eend);
				}

				// Shift the entire string over, with the new replacement text.
				size_t slen = strlen(s);
				site_t shift = slen - (end - ptr + 1);
				if (shift > 0) {
					memmove(end + shift + 1, end + 1, slen - (end - buf);
				}
				memcpy(ptr, s, slen);
				ptr += slen;
			} else {
			    ptr = end; // Continue parsing
			}
		}
	}
	
	fclose(fh);
	return EXIT_SUCCESS;
}
