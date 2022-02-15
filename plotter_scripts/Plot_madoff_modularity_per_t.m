
%% load modularity data for Madoff graph

load madoff_mod_t2.csv;
load madoff_mod_t3.csv;

%% plot figure
figure;

hold on;

plot(madoff_mod_t2,'--bs','Color','g','LineWidth',1);
plot(madoff_mod_t3,'--bs','Color','b','LineWidth',1);

legend('ECCD t=2','ECCD t=3');

title('Madoff');

savepdf('madoff_nikolaevetal.pdf');
