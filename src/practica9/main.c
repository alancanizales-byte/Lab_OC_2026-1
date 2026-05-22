#include <stdio.h>

extern int maximo(int *arr, int len);
extern int minimo(int *arr, int len);
extern int sumatoria(int *arr, int len);

int main(){
    int arr[5];
    int n;

    printf("Cantidad de elementos: ");
    scanf("%d", &n);

    if(n < 1 || n > 5){
        printf("Cantidad invalida");
        return 1;
    }

    for(int i = 0; i < n; i++){
        printf("Elemento [%d]: ");
        scanf("%d", &arr[i]);
    }

    printf("Elementos del arreglo:\n");

    for(int i = 0; i < n; i++){
        printf("%d ", arr[i]);
    }

    printf("\nMaximo: %d\n", maximo(arr, n));
    printf("Minimo: %d", minimo(arr, n));
    printf("Sumatoria: %d", sumatoria(arr, n));

    return 0;
}