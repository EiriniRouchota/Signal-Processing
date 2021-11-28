%%%Kvdikopoisi tis pigis B me dictA
%%%%%get source B
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
sourceB=char(ascii_number);
 
%%%%%%%%%%
%alphabet =char([97:122]); %ascii table letters a-z (97-122)
pro = [11.602 4.702 3.511 2.670 2.007 3.779 1.950 7.232 6.286 0.597 0.590 2.705 4.383 2.365 6.264 2.545 0.173 1.653 7.755 16.671 1.487 0.649 6.753 0.017 1.620 0.034]/100;
 
[X,Y] = meshgrid(1:26, 1:26); %create two matrixes with the same elements but different structure
newpB = prod(pro([X(:) Y(:)]'))'; %new propabilities of each double for dict from link
newpA = prod(proB([X(:) Y(:)]'))'; %new propabilities of each double for dict from kword
news = [1:676]'; %the total doubles are 676 = 26 * 26 
newsigB = reshape([double(sourceB)-96],2,numel(sourceB)/2)';
newsigB(:,1) = newsigB(:,1) - 1;
newsigB = newsigB(:,1)*26+newsigB(:,2)΄; %multiply by 26, our alphabet is from 1-676 not only 26
%%%%%%Follow the same procedure as before for Huffman code
newdictB = myhuffmandict(news,newpB);
newbB = myhuffmanenco(newsigB,newdictB);
numRespB = myhuffmandeco(newbB,newdictB); %Now decodedA has numbers, while sourceA is with double chars
newresp = ones(2,numel(sourceB)/2);%response matrix
newresp(2,:) = mod(numRespB,26);
temp = (newresp(2,:)==0);
newresp(newresp==0) = 26;
newresp(1,:) = floor(numRespB/26)+1;
newresp(1,temp) = newresp(1,temp)-1;
newresp = char(newresp+96); %from double to char a to z
newresp = newresp(:)';
%%%%Check if Huffman works
if strcmp(newresp,sourceB)
disp 'huffman code works with possibilites from link wiki'
end
a = info_table(newdictB,newbB)
 
%%%%%%%% copy paste from above but different possibilities
newdictA = myhuffmandict(news,newpA);
newbB = myhuffmanenco(newsigB,newdictA);
numRespB = myhuffmandeco(newbB,newdictA);
newresp = ones(2,numel(sourceB)/2);
newresp(2,:) = mod(numRespB,26);
temp = (newresp(2,:)==0);
newresp(newresp==0) = 26;
newresp(1,:) = floor(numRespB/26)+1;
newresp(1,temp) = newresp(1,temp)-1;
newresp = char(newresp+96);
newresp = newresp(:)';
if strcmp(newresp,sourceB)
disp 'huffman code works for text'
end
info_table(newdictA,newbB)
