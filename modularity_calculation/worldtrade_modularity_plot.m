%%
clear all;
close all;

%%
M = load('worldtrade.edgelist');

density_ = double(sum(M(:))) / double(size(M,1)*size(M,2));

fprintf(1, 'world_trade density = %2.4f%%\n', density_*100);

t_ = [1:5];
c_ = [2:89];

Modularities3 = double(zeros(length(t_),length(c_)));
Partitions3 = cell(length(t_),length(c_));

for t=1:length(t_)
    for c=1:length(c_)
        disp(['computing world_trade.txt partition with c=' int2str(c_(c)) ' communities with resolution t=' int2str(t_(t))]);
        
        [commstruct,cc] = ECCD(M,0.2,t_(t),c_(c),1);
        
        if cc == 0
            disp(['ECCD did not terminate in an acceptable state for c=' int2str(c)]);
        end
        
        if isempty(commstruct.communities)
            Modularities3(t,c) = 0;
            Partitions3{t,c} = 0;
        else
            Modularities3(t,c) = partition_modularity_directed(M,M,commstruct.community_indices);
            Partitions3{t,c} = commstruct.community_indices;
        end
    end
end

%%
figure;
hold on;

linestyle_ = {'r--','g--','b--','c--','m--'};
legends_ = {};

for p_=1:size(Modularities3,1)
    plot(c_, Modularities3(p_,:), linestyle_{p_}, 'LineWidth',2);
    legends_{p_} = strcat('locality t = ',int2str(t_(p_)));
end

xlabel('community number');
ylabel('Newman modularity');

legend(legends_);

title('community structure of KAPFMU graph analyzed by (Nikolaev, et al., 2015)');

savepdf('world_trade.pdf');

save('world_trade_modularity.mat');
