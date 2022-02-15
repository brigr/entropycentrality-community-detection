
%% load modularity data for domesticterror graph

load domesticterror_mod_t2.csv;
load domesticterror_mod_t3.csv;
load domesticterror_mod_t4.csv;

%% plot figure
figure;

hold on;

plot([2:31],domesticterror_mod_t2,'--bs','Color','g','LineWidth',1);
plot([2:31],domesticterror_mod_t3,'--bs','Color','b','LineWidth',1);
plot([2:31],domesticterror_mod_t4,'--bs','Color','b','LineWidth',1);

legend('ECCD t=2','ECCD t=3','ECCD t=4');

title('Domestic terror');

savepdf('domesticterror_nikolaevetal.pdf');
