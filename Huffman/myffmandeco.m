function [ sig ] = myhuffmandeco( bit_stream,dict )
N=size(dict,1)-1
sig = [];
for i=1:size(bit_stream,1)
 
for j=1:N
if isequal(dict{j+1,2},bit_stream{i})
sig = [sig dict{j+1,1}];
break;
end
end
end
end
