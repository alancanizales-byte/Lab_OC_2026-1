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
        printf("Cantidad invalida\n");
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
    printf("Maximo: %d\n", maximo(arr, n));

    for(int i = 0; i < n; i++){
        printf("%d ", arr[i]);
    }

    printf("\n");
    printf("Minimo: %d\n", minimo(arr, n));

    for(int i = 0; i < n; i++){
        printf("%d ", arr[i]);
    }

    printf("\n");
    printf("Sumatoria: %d\n", sumatoria(arr, n));
}