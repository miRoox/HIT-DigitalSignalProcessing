#include <stdio.h>
#include <math.h>
#include <conio.h>

#define re 0 /* re=0 ，用 用 re  表 示 实 部  */
#define im 1 /* im=1 ，用 用 im  表 示 虚 部 */

main()
{
    float x[128][2],w[2],temp[2];
    /*
    x[128][2] ：  复 数 变 量 ；
    x[i][re] ：  第 第 i  个 复 数 变 量 的 实 部 ；
    x[i][im] ： 第 第 i  个 复 数 变 量 的 虚 部 ；
    w[2] ： 存 储 旋 转 因子 子 W N P ，w[re] 、w[im] 分 别 代 表 旋 转 因 子 的 实 部 和 虚 部 ；
    temp[2] ：  蝶 形 计 算 中 的 临 时 变 量 ，temp[re] 、temp[im] 分 别 代 表 其 实 部 和 虚 部； ；
    */
    float arg,wreal,wimag;
    /* arg  存 储 旋 转 因 子 指数 数 p( 数 值 上 相 差-2 π π /N) 。wreal  存储 储 cos(arg) ，wimag  存 储
    -sin(arg) */
    float tem,tr,ti;
    int L,M,B,j,i,k, N,N2;
    char c='i';

    scanf("%d %d",&N,&M); /*  输 入 复 数 信 号 长度 度 N ， 蝶 形 运 算 级数 数 M */
    N2=N>>1;
    for (j=0;j<N;j++) /*  输 入 复 数 信 号 实 部 和 虚 部 */
    {
        scanf("%f %f",&x[j][re],&x[j][im]);
    }
    printf("\n");

    /* 输 入 倒 序*/
    for (j=0,i=1;i<N-1;i++)
    {
        k=N2;
        while (k<=j)
        {
            j=j-k;
            k=k>>1;
        }
        j=j+k;
        if (i<j)
        {
            tr=x[j][re];
            ti=x[j][im];
            x[j][re]=x[i][re];
            x[j][im]=x[i][im];
            x[i][re]=tr;
            x[i][im]=ti;
        }
    }

    /*FFT  三 重 循 环 模 块*/
    for (L=1; L<=M; L++) /*  逐 级 进 行 计 算共 共 M  级 */
    {
        B=1<<L-1; /* 第 第 L  级 共有 有 B=2 L-1 个 不 同 的 旋 转 因 子 */
        arg=-acos(-1)/B; /* 旋 转 因 子 初 始 化  注 释 见 结 尾 处 */
        w[re]=cos(arg);
        w[im]=-sin(arg);
        for (j=0; j<B; j++) /* j  代 表第 第 L  级 不 同 旋 转 因 子 的 个 数 */
        {
            /*  旋 转 因 子*/
            arg=acos(-1)/B; /* arg= π/Β */
            wreal=cos(arg);
            wimag= -sin(arg);
            tem=w[re]*wreal-w[im]*wimag;
            w[im]=w[re]*wimag+w[im]*wreal;
            w[re]=tem;
            for (k=j; k<N; k+=2*B)
            {
                temp[re] = x[k][re]-(x[k+B][re]*w[re]-x[k+B][im]*w[im]);
                temp[im] = x[k][im]-(x[k+B][im]*w[re]+x[k+B][re]*w[im]);
                x[k][re] = x[k][re]+(x[k+B][re]*w[re]-x[k+B][im]*w[im]);
                x[k][im] = x[k][im]+(x[k+B][im]*w[re]+x[k+B][re]*w[im]);
                x[k+B][re] = temp[re];
                x[k+B][im] = temp[im];
                /*  编 写 蝶 形 运 算 程 序 */
                /* 第 第 L  级 每 个 蝶 形 计 算 的 输 入 节 点 距 离为 为 B  */
                /*  蝶 形 运 算                */
                /*  利 用 临 时 存 储 变量 量 temp[2] 计算 算 W N P x[i+B] */
                /*  复 数 运 算 ：(a+bj)(c+dj)=(ac-bd)+(bc+ad)j */
                /* temp[re]= ac-bd ，temp[im]= bc+ad */
            }
        }
    }

    for (j=0;j<N;j++) /* 输 出*/
    {
        printf("%f+%f%c\n",x[j][re],x[j][im],c);
    }
    getch();

}
