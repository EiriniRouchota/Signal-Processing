function [info] = info_table(dict,code)
p = [dict{2:size(dict,1),4}];
H=p*log2(1./p)';
avglen = sum(cellfun(@double,dict(2:numel(p)+1,5))); 
efficiency = H/avglen;
for i=1:size(code,1)
       len(i)=length(code{i,1});
end;       
huffmanbits=sum(len);
info=table(H,avglen,huffmanbits,efficiency,'VariableNames',{'Entropy' 'Average Length' 'Huffman bits' 'efficiency'});
end
