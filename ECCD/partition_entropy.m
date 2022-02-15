function [partition_entropy] = partition_entropy(W,ROWS,COLS)

partition_entropy = double(0);

for i=1:ROWS
   v_entropy = double(0);
   v_tweight = double(sum(W(i,:)));
   
   for j=1:COLS
       if W(i,j) ~= 0
          p_mass = W(i,j)/v_tweight;
          v_entropy = v_entropy + p_mass*log2(p_mass); 
       end
   end
   
   partition_entropy = partition_entropy + v_entropy;
end
