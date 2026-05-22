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
        printf("Elemento [%d]: ", i);
        scanf("%d", &arr[i]);
    }

    printf("\nElementos del arreglo:\n");

    for(int i = 0; i < n; i++){
        printf("%d ", arr[i]);
    }
    printf("\n");

    printf("\nMaximo: %d", maximo(arr, n));
    printf("\nMinimo: %d", minimo(arr, n));
    printf("\nSumatoria: %d\n", sumatoria(arr, n));

    return 0;
}