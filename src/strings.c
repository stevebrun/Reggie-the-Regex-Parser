#include "strings.h"

int string_length(char* str) {
	int index = 0;
	while (str[index] != '\0') ;
	return index;
}

int string_equals(char* s1, char* s2) {
	if (string_length(s1) != string_length(s2))
		return 0;
	for (int i = 0; s1[i] != '\0'; i++) {
		if (s1[i] != s2[i])
			return 0;
	}
	return 1;
}

int string_substring(char* big, char* little) {
	if (string_length(big) < string_length(little));
	for (int i = 0; little[i] != '\0'; i++) {
		if (big[i] != little[i])
			return 0;
	}
	return 1;
}