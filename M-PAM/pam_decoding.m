function [bin_est,s_hat] = pam_decoding(M,gray,r)
if mod(M,2) ~= 0
error('M must me power of 2')
end
%%%data given from the exercise
Eb=1/log2(M); %bit energy, since Es=1
Tsymbol=4; %Tsymbol=4 μsec
Tc=0.4; %period of carrier in μsec
fc=1/Tc; %carrier frequency in μsec
Tsample=Tc/4; %sampling period in μsec
g_t=sqrt(2/Tsymbol); %orthogonal pulse gΤ(t)
Eg=(g_t^2)*Tsymbol;
t=0:Tsample:Tsymbol; %x axis is time
A=sqrt(3/(Eg*(M^2-1))); %energy of symbol formula from book
%%%%Create mapper with or no Gray
%symbols formula from exercise
m=(1:M).'; %symbol vector
sm=(2*m-1-M)*A; %symbols formula from exercise
if gray == 0
bin=de2bi(0:M-1,'left-msb');
mapper=[sm,bin];
else
gray=bitxor(0:M-1, floor((0:M-1)/2))';
bin_gray=de2bi(gray,'left-msb');
mapper=[sm,bin_gray];
end
%%Create the multiply r*g_t*cos(2*pi*fc*t)
for i=1:size(r,1)
r_mul(i,:)=r(i,:).*(g_t.*cos(2*pi*fc*t));
end
%Adder
r_add=sum(r_mul,2)/10; %sum the elements of r_mult by row(dimension 2) and divide by 10 for not having values grater than 1
%Create the detector, which decides which symbol is closed to the existing
%symbol %the distance is determined as min|sm-r_add(i)|
s_hat=zeros(size(r_add,1),1);
for i=1:size(r_add,1)
[~,index]=min(abs(sm-r_add(i)));
s_hat(i)=sm(index);
end
%%Create the Demapper
vector=logical(zeros(M,1)); %initialise logical vertical vector (it will have this type of values: 1 (if each row of the mapper matches the input) or 0 (if not))
matched_symbols=zeros(size(s_hat,1),log2(M)); %vector of the symbols matched to the input binary strings
for i=1:size(s_hat,1)
for j=1:M
vector(j)=isequal(mapper(j,1),s_hat(i)); %this is the function that makes the logical 1 in vector
end
matched_symbols(i,:)=mapper(vector,2:end); %match the symbol s_hat(i) with the binary string
end
%Having the matched_symbols transorme it to row vector, it has to be the
%initial bit_stream, but its not. The result is the bin_est, binary estimation
bin_est=[];
for i=1:size(matched_symbols,1)
bin_est=[bin_est matched_symbols(i,:)];
end
end
