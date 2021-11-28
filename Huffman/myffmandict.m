myffmandict

function [ dict, avglen ] = myhuffmandict(s, p ) %symbols my alphabet and p equals to probabilities of each symbol
if length(s) ~= length(p),  
    error('The vector s and p must have the same dimensions')
end;
 
if (sum(p)-1)>10e-10,
    error('The sum of propabilities must equal to one')
end;
 
p = p(:)';
n=length(p);
q=p; %copy the propabilities to vector q 
m=zeros(n-1,n);
 
for i=1:n-1,
    [q,l]=sort(q); 
    m(i,:)=[l(1:n-i+1),zeros(1,i-1)]; 
    q=[q(1)+q(2),q(3:n),1];
    
end;
 
%initialize the matrix c, which keeps the prefix code
for i=1:n-1,
    c(i,:)=blanks(n*n);
end;
 
c(n-1,n)='0'; %put the first zero starting from the bottom
c(n-1,2*n)='1'; %put the first one starting from the bottom
 
for i=2:n-1, %make the code to be prefix with zeros and ones
    c(n-i,1:n-1)=c(n-i+1,n*(find(m(n-i+1,:)==1))-(n-2):n*(find(m(n-i+1,:)==1)));
    c(n-i,n)='0' ;
    c(n-i,n+1:2*n-1)=c(n-i,1:n-1);
    c(n-i,2*n)='1';
    for j=1:i-1,
        c(n-i,(j+1)*n+1:(j+2)*n)=c(n-i+1,...  
            n*(find(m(n-i+1,:)==j+1)-1)+1:n*find(m(n-i+1,:)==j+1));  
    end;
end;
 
for i=1:n, %calculate the length of each codeword
    code(i,1:n)=c(1,n*(find(m(1,:)==i)-1)+1:find(m(1,:)==i)*n);%the code for each symbol (in ascii format)
    len(i)=length(find(abs(code(i,:))~=32)); %the number of bits needed for each code
 
end
 
   dict = cell(numel(p)+1,5); %create a dict type cell with rows=number of possibilities and 5 columns
   dict{1,1} = {'Symbols'};
    dict{1,2}= {'Codeword'};
    dict{1,3} = {'length of codeword'};
    dict{1,4} = {'possibility of each symbols'};
    dict{1,5}=  {'len(i)*p(i)'};
    
    for i=2:numel(p)+1
        dict{i,1} = s(i-1);
        tempC = double(code(i-1,:))-48;
        dict{i,2} = tempC(tempC>=0);
        dict{i,3} = len(i-1);
        dict{i,4} = p(i-1);
        dict{i,5} = dict{i,3}*dict{i,4};
        
    end
   
avglen = sum(cellfun(@double,dict(2:numel(p)+1,5))); %calculate the sum of p(i)*length(i)
 
end
