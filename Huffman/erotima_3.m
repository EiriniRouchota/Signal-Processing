ascii_number = double(lower(fscanf(fopen('kwords.txt','r'),'%s')))-96; %keep the ascii number of each letter of file kwords. Because the numbers exceeds 96(means not letters a to z) we substract 96 
ascii_number= ascii_number(ascii_number>0 & ascii_number<=26)+96;%ascii format in order all symbolas must me letters(97-122)
sorted_ascii=char(sort(unique(ascii_number)));%letters in order
A=(sort(unique(ascii_number)));
[A,j] = unique(A(:)) ; 
[Idx ,Idx] = ismember(ascii_number,A);%returns the index in which element of ascii_number is found on matrix A
count = histc(Idx(:),1:length(A)) ;%calculates the occurences of each symbol
%%%find the possibilites of each symbol in the 'kwords' text
count=count';
proB=count/sum(count);
sourceB=char(ascii_number);%generate the correct source  
dictB=myhuffmandict(sorted_ascii,proB); %follow the same procedure as before
codeB=myhuffmanenco(sourceB,dictB);
decodedB=myhuffmandeco(codeB,dictB);
if strcmp(sourceB,decodedB)
    disp('Huffman code works for source B')
end;
info_table(dictB,codeB)
