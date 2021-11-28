SNR=0:5:40;%9 different values of SNR
SER=zeros(1,9);
BER=zeros(1,9);
hold on
for i=1:1:9
[~,BER(i),SER(i)]=calculate(bit_stream,2,0,SNR(i));
end
close all;
ber_fig=figure('Name','BER');
semilogy(SNR,BER);
hold on %hold ber figure
for i=1:1:9
[~,BER(i),~]=calculate(bit_stream,4,0,SNR(i));
end
figure(ber_fig);
semilogy(SNR,BER);
hold on
for i=1:1:9
[~,BER(i),~]=calculate(bit_stream,8,0,SNR(i));
end
figure(ber_fig);
semilogy(SNR,BER);
hold on
for i=1:1:9
[~,BER(i),~]=calculate(bit_stream,2,0,SNR(i));
end
figure(ber_fig);
semilogy(SNR,BER);
hold on
for i=1:1:9
[~,BER(i),~]=calculate(bit_stream,4,1,SNR(i));
end
figure(ber_fig);
semilogy(SNR,BER);
hold on
for i=1:1:9
[~,BER(i),~]=calculate(bit_stream,8,1,SNR(i));
end
figure(ber_fig);
semilogy(SNR,BER);
hold on
for i=1:1:9
[~,BER(i),~]=calculate(bit_stream,16,1,SNR(i));
end
figure(ber_fig);
semilogy(SNR,BER);
legend('M=0, Regular','M=4, Regular','M=8, Regular','M=2, Regular', 'M=4, GRAY','M=8, GRAY','M=16, GRAY');
hold off %close ber figure
