SNR=0:5:40;
SER=zeros(1,9);
BER=zeros(1,9);
for i=1:1:9
[~,~,SER(i)]=calculate(bit_stream,4,0,SNR(i));
end
ser_fig=figure('Name','SER');
figure(ser_fig);
semilogy(SNR,SER);
hold on
for i=1:1:9
[~,~,SER(i)]=calculate(bit_stream,8,0,SNR(i));
end
figure(ser_fig);
semilogy(SNR,SER);
hold on
for i=1:1:9
[~,~,SER(i)]=calculate(bit_stream,16,0,SNR(i));
end
figure(ser_fig);
semilogy(SNR,SER);
hold on
for i=1:1:9
[~,~,SER(i)]=calculate(bit_stream,4,1,SNR(i));
end
figure(ser_fig);
semilogy(SNR,SER);
hold on
for i=1:1:9
[~,~,SER(i)]=calculate(bit_stream,8,1,SNR(i));
end
figure(ser_fig);
semilogy(SNR,SER);
hold on
for i=1:1:9
[~,~,SER(i)]=calculate(bit_stream,16,1,SNR(i));
end
figure(ser_fig);
semilogy(SNR,SER);
legend('M=4, Regular','M=8, Regular','M=16, Regular', 'M=4, GRAY','M=8, GRAY','M=16, GRAY');
hold off
