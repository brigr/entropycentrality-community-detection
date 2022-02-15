function [] = savepdf(str)
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperType', 'A4');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 200 200]);
set(gcf, 'PaperSize', [200 200]);

print('-dpdf', str);
