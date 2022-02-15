function [edge_count] = count_edges_from_adjacency(A,ROWS,COLS)

edge_count = length(find(A(:) ~= 0));
