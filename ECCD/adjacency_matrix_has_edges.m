function [has_edges] = adjacency_matrix_has_edges(A)

nz_idx = find(A(:) ~= 0);

if nz_idx > 0
    has_edges = 1;
else
    has_edges = 0;
end
