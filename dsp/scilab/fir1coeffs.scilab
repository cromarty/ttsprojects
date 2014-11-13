//
// Prints a fragment of C code containing floating point and integer FIR
// filter coefficients
//

// bandpass filter centred at 1000 Hz

// sample rate
sr=8000;

// number of taps
nf=63;

bedge=[0,800/sr;900/8000,1100/8000;1200/8000,4000/8000];
des=[0 1 0];
wate=[1 1 1];

[hn]=eqfir(nf,bedge,des,wate);

// I don't think plots work on the cli version of scilab(?)
//[hm,fr]=frmag(hn,256);
//plot(fr, hm);

[n1,n2]=size(hn);

printf("#ifndef INTEGER_COEFFS\n\n");

n = 1;
printf("\tdouble coeffs[FILTER_LEN] = {\n\t\t");
while n <= n2
rm = n2 - n;
printf("%f", hn(1,n));
if rm > 0 then
printf(", ");
end
if modulo(n, 8) == 0 then
printf("\n\t\t");
end
n = n + 1;
end
printf("\n\t};\n\n");

printf("\n#else\n\n");


n = 1;
printf("\tshort coeffs[FILTER_LEN] = {\n\t\t");
while n <= n2
rm = n2 - n;
printf("%d", round(hn(1,n)*32768));
if rm > 0 then
printf(", ");
end
if modulo(n, 8) == 0 then
printf("\n\t\t");
end
n = n + 1;
end
printf("\n\t};\n\n");





printf("#endif\n\n");


quit;
