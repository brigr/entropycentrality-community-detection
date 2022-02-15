function [communities,edges_exhausted] = ECCD(A,a,t,k,debug,use_sp_matrix)

if nargin ~= 5 && nargin ~= 6
   debug = 1; 
end

if nargin ~= 6
   use_sp_matrix = 0;
end

if use_sp_matrix == 1 && ~issparse(A)
    A = sparse(A);
end

ROWS = size(A,1);
COLS = size(A,2);

edges_exhausted = 0;
communities = struct('communities',[],'community_indices',[]);

% make sure that rows equal columns in count
assert(ROWS == COLS);

% iteration count
iteration_cnt_ = 1;

while adjacency_matrix_has_edges(A) ~= 0
    % calculate the absorbing Markov transition matrix
    M_trans = calculate_transition_matrix(A,a,t,ROWS,COLS);
    
    % calculate the entropy centrality of each vertex in the graph
    current_node_centralities = calculate_vertex_entropy_centralities(M_trans,ROWS,COLS);
    
    % calculate the 
    edge_count = count_edges_from_adjacency(A,ROWS,COLS);
    
    % calculate the reduced adjacency matrix A by removing 1 edge each time
    [A_matrices,A_edges] = calculate_reduced_adjacency_matrices(A,ROWS,COLS);
    
    % calculate new centralities that will be formed
    next_node_centralities = [];
    
    for A_case=1:edge_count
        % calculate the absorbing Markov transition matrix
        M_trans_ = calculate_transition_matrix(A_matrices{A_case},a,t,ROWS,COLS);
        
        % calculate the entropy centrality of each vertex in the graph
        current_node_centralities_ = calculate_vertex_entropy_centralities(M_trans_,ROWS,COLS);
        
        next_node_centralities = [ next_node_centralities; current_node_centralities_ ];
    end
    
    % calculate the difference matrix of the centralities
    centrality_diff_matrix = next_node_centralities;
    for i=1:size(centrality_diff_matrix,1)
        centrality_diff_matrix(i,:) = current_node_centralities - centrality_diff_matrix(i,:);
    end
    
    % calculate vector of the average difference
    average_difference_of_pivot = double(zeros(1,size(centrality_diff_matrix,1)));
    
    for i=1:size(centrality_diff_matrix,1)
       average_difference_of_pivot(i) = mean(centrality_diff_matrix(i,:)); 
    end
    
    % find pivot index with maximum average decrease in average centrality
    [min_val, min_idx] = max(average_difference_of_pivot);
    
    A = sparse(A_matrices{min_idx});
    
    %disp(['removing 1 edge to get new matrix']);
    
    % compute connected components from the adjacency matrix
    %[S,C] = graphconncomp(A);
    %[S,C] = conncomp(A);

    [l,c] = graph_conn_comp(A);
    
    if c <= k
      communities = struct('communities',l,'community_indices',l,'node_centralities',next_node_centralities(min_idx,:));
    end
    if debug == 1
        disp(['iteration ' int2str(iteration_cnt_) ' completed...']);
    end
    
    iteration_cnt_ = iteration_cnt_ + 1;

end

if adjacency_matrix_has_edges(A) == 0
    edges_exhausted = 1;
    disp(['ECCD terminated successfully.']);
else
    disp(['ECCD terminated in an unsteady state.']);
end
