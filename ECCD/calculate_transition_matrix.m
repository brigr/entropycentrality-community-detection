function [M_trans] = calculate_transition_matrix(A,a,t,ROWS,COLS)

% make the absorbing transition matrix
Ab = double(eye(ROWS))*a;

% make the Markov transition matrix
A_1 = A;
A_2 = repmat(sum(A')',1,size(A,2));
P = A_1 ./ A_2;

% make the zeros matrix
Z = double(zeros(ROWS,COLS));

% make the diagonal all-ones matrix
A1 = double(eye(ROWS));

% make the absorbing Markov transition matrix
M = [ [P Ab] ; [Z A1] ];

% compute node entropy centralities
if issparse(A)
    %M_trans = sparse(power(M,t));
    M_trans = sparse(M);
    for t_=2:t
        M_trans = M_trans * M;
    end
else
    %M_trans = power(M,t);
    M_trans = M;
    for t_=2:t
        M_trans = M_trans * M;
    end
end
