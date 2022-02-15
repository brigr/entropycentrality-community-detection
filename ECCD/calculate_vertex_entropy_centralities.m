function [vertex_centralities] = calculate_vertex_entropy_centralities(M_trans,ROWS,COLS)

P_1 = M_trans(1:ROWS,1:COLS);
P_2 = M_trans(1:ROWS,COLS+1:end);
P = P_1 + P_2;
P_ents = -1 * P .* log2(P);

vertex_centralities = sum(P_ents');
