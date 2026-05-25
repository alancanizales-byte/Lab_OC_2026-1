#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void set_bit(unsigned char *value, unsigned char bit);
extern unsigned char get_bit(unsigned char value, unsigned char bit);

void limpiar(unsigned char *f);
void update_temp(int *temps);
void update_flags(int *temps, int *last, unsigned char *flags);
void mostrar(unsigned char f);

#define U 5
#define D 4
#define G 3
#define T 2
#define O 1
#define N 0

int main(){
    srand(time(NULL));
    unsigned char banderas[2] = {0,0};
    int ultima_lectura[2] = {25,25};
    int tem_sensores[2] = {25,25};

    set_bit(&banderas[0], N);
    set_bit(&banderas[1], N);

    int op;

    do{
        printf("\n");
        for(int i = 0; i < 2; i++){
            printf("SENSOR %d: ~ %d °C ", i + 1, tem_sensores[i]);
            mostrar(banderas[i]);
            printf("\n");
        }
        printf("\n[1] Actualizar\n");
        printf("[2] Salir\n");
        printf("\nSeleccionar opcion: ");
        scanf("%d", &op);

        switch(op){
            case 1:
                update_temp(tem_sensores);
                update_flags(tem_sensores, ultima_lectura, banderas);
                break;

            case 2:
                break;

            default:
                printf("\nOpcion invalida\n");
        }
    }while(op != 2);
    return 0;
}

void limpiar(unsigned char *f){ 
    *f = 0; 
}

void update_temp(int *temps){
    for(int i = 0; i < 2; i++){
        int cambio = (rand() % 11) - 5;
        temps[i] += cambio;
    }
}

void update_flags(int *temps, int *last, unsigned char *flags){
    for(int i = 0; i < 2; i++){
        limpiar(&flags[i]);
        int dif = temps[i] - last[i];
        if(dif == 0){
            set_bit(&flags[i], N);
        } else {
            if(dif > 0) 
                set_bit(&flags[i], U);
            else        
                set_bit(&flags[i], D);
            int abs_dif = abs(dif);
            if(abs_dif == 1)      
                set_bit(&flags[i], O);
            else if(abs_dif == 2) 
                set_bit(&flags[i], T);
            else                  
                set_bit(&flags[i], G);
        }
        last[i] = temps[i];
    }
}

void mostrar(unsigned char f){
    if(get_bit((unsigned char)f,N)){
        printf("-");
    } else {
        if(get_bit((unsigned char)f,D)){
            if(get_bit((unsigned char)f,O))
                printf("<");
            else if(get_bit((unsigned char)f,T))
                printf("<<");
            else
                printf("<<<");
        }

        if(get_bit((unsigned char)f,U)){
            if(get_bit((unsigned char)f,O))
                printf(">");
            else if(get_bit((unsigned char)f,T))
                printf(">>");
            else
                printf(">>>");
        }
    }
}