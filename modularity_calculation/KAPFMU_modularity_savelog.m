clear all;
close all;

M = load('KAPFMU.dat');

tvals = 1:3;

communities = cell(length(tvals),35);
modularities = cell(length(tvals),35);

for t=1:length(tvals)
    for c=2:size(M,1)
        disp(['computing KAPFMU partition with c=' int2str(c) ' communities.']);
        
        % compute community structure
        [communities{t,c-1},cc] = ECCD(M,0.2,tvals(t),c,0,0);
        
        if cc == 0
            disp(['ECCD did not terminate in an acceptable state for c=' int2str(c)]);
        end
        
        if isempty(communities{t,c-1}.community_indices)
            modularities{t,c-1} = Inf;            
        else
            % compute directed modularity for the graph partition
            modularities{t,c-1} = partition_modularity_directed(M,M,communities{t,c-1}.community_indices);
            
            % write communities
            csvwrite(strcat('KAPFMU_mod_t',int2str(t),'_c',int2str(c),'_communities.csv'),communities{t,c-1}.community_indices);
            
            % write node centralities
            csvwrite(strcat('KAPFMU_mod_t',int2str(t),'_c',int2str(c),'_centralities.csv'),communities{t,c-1}.node_centralities);
            
            % write modularity
            csvwrite(strcat('KAPFMU_mod_t',int2str(t),'_c',int2str(c),'_modularity.csv'),modularities{t,c-1});
        end
    end    
end
