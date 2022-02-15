function [modularity] = partition_modularity_directed(A,W,a)

modularity = double(0.0);

ROWS = size(A,1);
COLS = size(A,2);

assert(ROWS == size(W,1) && COLS == size(W,2));

k_out = double(sum(A));
k_in = double(sum(A'));

m = double(sum(A(:)));

W = double(W);
A = double(A);

for i=1:ROWS
    for j=1:COLS
        if a(i) == a(j)
            modularity = modularity + W(i,j) - (k_out(j)*k_in(i))/(m);
        end
    end
end

modularity = modularity / (m);
