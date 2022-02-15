clear all;
close all;

M = load('madoff.edgelist');

communities = cell(1,60);
modularities = cell(1,60);

for t=2:5
    for c=2:61
        disp(['computing madoff partition with c=' int2str(c) ' communities.']);
        
        [communities{c-1},cc] = ECCD(M,0.2,t,c,0);
        
        if cc == 0
            disp(['ECCD did not terminate in an acceptable state for c=' int2str(c)]);
        end
        
        if isempty(communities{c-1}.community_indices)
            modularities{c-1} = 0;
        else
            modularities{c-1} = partition_modularity(M,M,communities{c-1}.community_indices);
        end
    end
    
    D1 = [2:61];
    D2 = cell2mat(modularities)
    
    csvwrite(strcat('madoff_mod_t',int2str(t),'.csv'),D2);
end
