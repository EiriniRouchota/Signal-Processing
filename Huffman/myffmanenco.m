function bit_stream = myhuffmanenco(signal,dict)
symbols = [dict{2:size(dict,1),1}]; %get the symbols from dict 
bit_stream = cell(numel(signal),1); %initialize the bit stream
for i = 1:numel(bit_stream)
index = strfind(symbols,signal(i));%search the signal(i) to find in the symbols and keeps the index
bit_stream{i} = dict{index+1,2}; %get the codeword of that symbol
end
end

