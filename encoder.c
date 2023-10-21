#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define CODE 98

int main(){
    const int max_len = 512 - 2 - 16 - CODE;
    char msg[max_len];
    uint8_t len;
    char key[16];
    int key_len;

    printf("Print msg: ");
    fgets(msg, max_len, stdin);
    len = strlen(msg) - 1;
    if(len > max_len){
        perror("Too big message\n");
        return 0;
    }

    printf("Print key: ");
    scanf("%s", key);
    key_len = strlen(key);


    FILE* boot = fopen("floppy.bin", "rb+");
    if(!boot){
        perror("Can't open file\n");
        return 0;
    }
    if(fseek(boot, CODE, SEEK_SET) != 0){
        perror("Incorrect file offset\n");
        return 0;
    }

    fwrite(&len, 1, 1, boot);

    for(int i = 0; i < len; i++){
        char k = msg[i] ^ key[i % key_len];
        fwrite(&k, 1, 1, boot);
    }

    fclose(boot);
    return 0;
}