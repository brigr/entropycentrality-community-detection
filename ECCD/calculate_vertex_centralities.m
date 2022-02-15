function [vertex_centralities] = calculate_vertex_entropy_centralities(M_trans,ROWS,COLS)

vertex_centralities = double(zeros(1,ROWS));

for i=1:ROWS
    entropy_val = 0.0;
    for j=1:COLS
        entropy_val = entropy_val + (M_trans(i,j) + M_trans(i,j+COLS)) * log2(M_trans(i,j) + M_trans(i,j+COLS));
    end
    
    vertex_centralities(i) = -1 * entropy_val;
end
