function [r,matched_symbols,signal] = pam_coding(bit_stream,M,gray,SNR)
if mod(M,2) ~= 0
error('M must me power of 2')
end
%%%data given from the exercise
Eb=1/log2(M); %bit energy, since Es=1
Tsymbol=4; %Tsymbol=4 μsec
Tc=0.4; %period of carrier in μsec
fc=1/Tc; %carrier frequency in μsec
Tsample=Tc/4; %sampling period in μsec
No=Eb/10^(SNR/10); %since SNR=10log(Eb/No)
g_t=sqrt(2/Tsymbol); %orthogonal pulse gΤ(t)
Eg=(g_t^2)*Tsymbol;
t=0:Tsample:Tsymbol; %x axis is time
A=sqrt(3/(Eg*(M^2-1))); %energy of symbol formula from book
%%%%Create mapper with or no Gray
m=(1:M); %symbol vector
sm=(2*m-1-M)*A; %symbols formula from exercise
if gray == 0
bin=de2bi(0:M-1,'left-msb');
mapper=[sm',bin];
else
gray=bitxor(0:M-1, floor((0:M-1)/2))';
bin_gray=de2bi(gray,'left-msb');
mapper=[sm',bin_gray];
end
%Matrix that contains rows that have log2(M) elements. The
%%number of them must be length(bit_stream)/log2(M) in order
%%%to be all represented
col=log2(M);
row=ceil(length(bit_stream)/log2(M)); %if the division is not interger, round to the nearest integer
mat=zeros(row,col);
for i=1:row
for j=1:col
if (i-1)*col+j>length(bit_stream) %if the index goes beyond the length of x, then stop
break
end
mat(i,j)=bit_stream(1,(i-1)*log2(M)+j);
end
end
%%%%%%Create a vector that it is initialized with zeros. It is used to find
%%%%%%if each column (2:end) of mapper equals to the bit_stream.If yes then
%%%%%%vector becomes 1
vector=logical(zeros(M,1));
matched_symbols=zeros(row,1); %symbols that are matched with the initial bit_stream
for i=1:row
for j=1:M
vector(j)=isequal(mapper(j,2:end),mat(i,:)); %this is the function that makes the logical 1 in vector
end
matched_symbols(i)=mapper(vector,1);
end
%%%Implement the signals
signal=matched_symbols*g_t.*cos(2*pi*fc*t);
%Create White Noise
%noise=(No/2)*random(size(signal)); %No/2 is the variance
noise=random('Normal',0,sqrt(No/2),size(signal));
%Add noise to the signal
r=signal+noise;
% figure;
%hold on
%for i=1:size(r,1)
% plot(t,r(i,:));
%end
%hold off
end
