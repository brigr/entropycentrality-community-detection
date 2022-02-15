function [A_reduced, A_edges] = calculate_reduced_adjacency_matrices(A,ROWS,COLS)

% count how many edges exist in the adjacency matrix
current_edges_count = count_edges_from_adjacency(A,ROWS,COLS);

% make cell of reduced matrix cases
A_reduced = cell(1,current_edges_count);
A_edges = cell(1,current_edges_count);

% compute all reduced cases
current_iter = 1;

for i=1:ROWS
   for j=1:COLS
      if A(i,j) ~= 0
         % compute case by zero-ing out entry
         A_copy = A;
         A_copy(i,j) = 0;
         
         % store result
         A_reduced{current_iter} = A_copy;
         A_edges{current_iter} = struct('A',i,'B',j);
         
         % which next
         current_iter = current_iter + 1;
      end
   end
end
