gcc -o fft.exe fft.c
@pause
type input1.txt | fft.exe > output1.txt
type input2.txt | fft.exe > output2.txt
type input3.txt | fft.exe > output3.txt
