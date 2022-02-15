clear all;
close all;

M = load('domesticterror.edgelist');

communities = cell(5,size(M,1)-1);
modularities = cell(5,size(M,1)-1);

for t=1:5
    for c=2:size(M,1)
        disp(['computing domesticterror partition with c=' int2str(c) ' communities.']);
        
        % compute community structure
        [communities{t,c-1},cc] = ECCD(M,0.2,t,c,0,0);
        
        if cc == 0
            disp(['ECCD did not terminate in an acceptable state for c=' int2str(c)]);
        end
        
        if isempty(communities{t,c-1}.community_indices)
            modularities{t,c-1} = Inf;
        else
            % compute directed modularity for the graph partition
            modularities{t,c-1} = partition_modularity_directed(M,M,communities{t,c-1}.community_indices);
            
            % write communities
            csvwrite(strcat('domesticterror_mod_t',int2str(t),'_c',int2str(c),'_communities.csv'),communities{t,c-1}.community_indices);
            
            % write node centralities
            csvwrite(strcat('domesticterror_mod_t',int2str(t),'_c',int2str(c),'_centralities.csv'),communities{t,c-1}.node_centralities);
            
            % write modularity
            csvwrite(strcat('domesticterror_mod_t',int2str(t),'_c',int2str(c),'_modularity.csv'),modularities{t,c-1});
        end
    end    
end
