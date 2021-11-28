alphabet =char([97:122]); %ascii table letters a-z (97-122)
prob =[0.0816700000000000;0.0149200000000000;0.0278200000000000;0.0425300000000000;0.127020000000000;0.0222800000000000;0.0201500000000000;0.0609400000000000;0.0696600000000000;0.00153000000000000;0.00772000000000000;0.0402500000000000;0.0240600000000000;0.0674900000000000;0.0750700000000000;0.0192900000000000;0.000950000000000000;0.0598700000000000;0.0632700000000000;0.0905600000000000;0.0275800000000000;0.00978000000000000;0.0236000000000000;0.00150000000000000;0.0197400000000000;0.000750000000000177]';
sourceA = alphabet(randsrc(1,10000,[1:26; prob]));
 
[X,Y] = meshgrid(1:26, 1:26); %create two matrixes with the same elements but different structure
newp = prod(prob([X(:) Y(:)]'))'; %new propabilities of each double
news = [1:676]'; %the total doubles are 676 = 26 * 26 
newsig = reshape([double(sourceA)-96],2,5000)'; %produce our new sourceA,which includes now doubles
newsig(:,1) = newsig(:,1) - 1;
newsig = newsig(:,1)*26+newsig(:,2);%multiply by 26, our alphabet is from 1-676 not only 26
%%%%%%Follow the same procedure as before for Huffman code
newdict = myhuffmandict(news,newp);
codeA= myhuffmanenco(newsig,newdict);
decodedA = myhuffmandeco(codeA,newdict); %Now decodedA has numbers, while sourceA is with double chars
%%%%%%%%%%%%%%
newresp = ones(2,5000); %response matrix
newresp(2,:) = mod(decodedA,26);
temp = (newresp(2,:)==0);
newresp(newresp==0) = 26;
newresp(1,:) = floor(decodedA/26)+1;
newresp(1,temp) = newresp(1,temp)-1;
%%%%Check if Huffman works
newresp = char(newresp+96); %from double to char a to z
newresp = newresp(:)';
if strcmp(newresp,sourceA)
disp 'Huffman code works for doubled SourceA'
end
info_table(newdict,codeA)
