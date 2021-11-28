function [bin_est,ber,ser] = calculate(bit_stream,M,gray,SNR)
[r,s_hat,~] = pam_coding(bit_stream,M,gray,SNR);
[bin_est,sw] = pam_decoding(M,gray,r);
bin_est=bin_est(1:length(bit_stream));
ber=sum(bit_stream~=bin_est)/length(bit_stream)
ser=sum(s_hat~=sw)/length(s_hat)
end
