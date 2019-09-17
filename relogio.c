#include <stdio.h>
#include <stdlib.h>
int main(){
    int seg1 = 0;
    int seg2 = 0;
    int min1 = 0;
    int min2 = 0;
    int h1 = 0;
    int h2 = 0;

    while(1){
        while( h2!=2 || h1!=4 ){
            while(min2!=5 || min1!=9){
                while( seg2!=5 || seg1!=9 ){
                        if(seg1<9){
                            seg1++;
                            //printf("%d%d:%d%d:%d%d\n", h2, h1, min2, min1, seg2, seg1);
                            //sleep(0,3);
                        }
                        else{
                            seg1 = 0;
                            if(seg2<5) seg2++;
                            //printf("%d%d:%d%d:%d%d\n", h2, h1, min2, min1, seg2, seg1);
                            //sleep(0,3);
                        }
                }
                seg1 = 0;
                seg2 = 0;
                if(min1 < 9) min1++;
                else{
                    min1 = 0;
                    min2++;
                }
            }
            min1 = 0;
            min2 = 0;
            if(h1<9) h1++;
            else{
                h1 = 0;
                h2++;
            }
        }
        h1 = 0;
        h2 = 0;
    }
}