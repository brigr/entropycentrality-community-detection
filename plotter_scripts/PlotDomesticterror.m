clear all;
close all;

S = double(zeros(5,31));

for t=1:5
   for c=2:32
      S(t,c-1) = load(strcat('domesticterror_mod_t',int2str(t),'_c',int2str(c),'_modularity.csv'));
   end
end

figure(1);
hold on;

linestyles = {'r--s','b--s','m--s','c--s','g--s'};

for t=1:5
  plot([2:32], S(t,:), 'LineWidth', 2, linestyles{t});
end

legend('t=1','t=2','t=3','t=4','t=5');