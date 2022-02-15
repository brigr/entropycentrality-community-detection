
%% load modularity data for Sawmill graph

load sawmill_mod_t2.csv;
load sawmill_mod_t3.csv;
load sawmill_mod_t4.csv;

%% plot figure
figure;

hold on;

plot([2:36],sawmill_mod_t2,'--bs','Color','g','LineWidth',1);
plot([2:36],sawmill_mod_t3,'--bs','Color','b','LineWidth',1);
plot([2:36],sawmill_mod_t4,'--bs','Color','r','LineWidth',1);

legend('ECCD t=2','ECCD t=3','ECCD t=4');

title('Sawmill');

savepdf('sawmill_nikolaevetal.pdf');
