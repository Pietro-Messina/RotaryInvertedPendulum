%% open loop
subplot(211); plot(real1); hold on; plot(sim1); hold off;
subplot(212); plot(real2); hold on; plot(sim2); hold off;
sqrdError1 = 0;
sqrdError2 = 0;

for i=1:length(real1)
    sqrdError1 = sqrdError1 + (real1(i) - sim1(i))^2;
    sqrdError2 = sqrdError2 + (real2(i) - sim2(i))^2;
end
RMSD1 = sqrt(sqrdError1/i);
RMSD2 = sqrt(sqrdError2/i);
NRMSD1 = RMSD1/(max(real1)-min(real1));
NRMSD2 = RMSD2/(max(real2)-min(real2));
% NRMSD1 = RMSD1/(mean(out.real1));
% NRMSD2 = RMSD2/(mean(out.real2));

%% control
subplot(211); plot(out.real1); hold on; plot(out.sim1); hold off;
subplot(212); plot(out.real2); hold on; plot(out.sim2); hold off;
sqrdError1 = 0;
sqrdError2 = 0;

for i=1:length(out.real1)
    sqrdError1 = sqrdError1 + (out.real1(i) - out.sim1(i))^2;
    sqrdError2 = sqrdError2 + (out.real2(i) - out.sim2(i))^2;
end
RMSD1 = sqrt(sqrdError1/i);
RMSD2 = sqrt(sqrdError2/i);
NRMSD1 = RMSD1/(max(out.real1)-min(out.real1));
NRMSD2 = RMSD2/(max(out.real2)-min(out.real2));
% NRMSD1 = RMSD1/(mean(out.real1));
% NRMSD2 = RMSD2/(mean(out.real2));

%% bang bang swingup
real2 = -data_28_May_2024_15_50_41(3,:)*2*pi/2048;
plot(real2); hold on; plot(out.sim2); hold off;
sqrdError1 = 0;
sqrdError2 = 0;

for i=1:length(out.sim2)
    sqrdError2 = sqrdError2 + (real2(i) - out.sim2(i))^2;
end
RMSD2 = sqrt(sqrdError2/i);
NRMSD2 = RMSD2/(max(real2)-min(real2));
% NRMSD2 = RMSD2/(mean(out.real2));

%% energy swingup
plot(out.real2); hold on; plot(out.sim2); hold off;
sqrdError2 = 0;

for i=1:length(out.real2)
    sqrdError2 = sqrdError2 + (out.real2(i) - out.sim2(i))^2;
end
RMSD2 = sqrt(sqrdError2/i);
NRMSD2 = RMSD2/(max(out.real2)-min(out.real2));
% NRMSD2 = RMSD2/(mean(out.real2));