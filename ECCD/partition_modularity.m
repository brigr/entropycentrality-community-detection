function [modularity] = partition_modularity(A,W,a)

modularity = double(0.0);

ROWS = size(A,1);
COLS = size(A,2);

assert(ROWS == size(W,1) && COLS == size(W,2));

k = double(sum(A));
m = double(sum(A(:)));

W = double(W);
A = double(A);

for i=1:ROWS
    for j=1:COLS
        if a(i) == a(j) && A(i,j) == 1
            modularity = modularity + W(i,j) - (k(i)*k(j))/(2*m);
        end
    end
end

modularity = modularity / (2*m);
