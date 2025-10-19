staticGains = [];

file3_02_sg = load('TestTOT_0.2sca_STATGAIN.mat');
file3_03_sg = load('TestTOT_0.3sca_STATGAIN.mat');
file3_04_sg = load('TestTOT_0.4sca_STATGAIN.mat');
file3_05_sg = load('TestTOT_0.5sca_STATGAIN.mat');
file3_06_sg = load('TestTOT_0.6sca_STATGAIN.mat');
file3_07_sg = load('TestTOT_0.7sca_STATGAIN.mat');
file3_08_sg = load('TestTOT_0.8sca_STATGAIN.mat');
file3_09_sg = load('TestTOT_0.9sca_STATGAIN.mat');
file3_10_sg = load('TestTOT_1.0sca_STATGAIN.mat');
file3_11_sg = load('TestTOT_1.1sca_STATGAIN.mat');
file3_12_sg = load('TestTOT_1.2sca_STATGAIN.mat');

staticGains(1)  = getStaticGain(file3_02_sg) / 0.2;
staticGains(2)  = getStaticGain(file3_03_sg) / 0.3;
staticGains(3)  = getStaticGain(file3_04_sg) / 0.4;
staticGains(4)  = getStaticGain(file3_05_sg) / 0.5;
staticGains(5)  = getStaticGain(file3_06_sg) / 0.6;
staticGains(6)  = getStaticGain(file3_07_sg) / 0.7;
staticGains(7)  = getStaticGain(file3_08_sg) / 0.8;
staticGains(8)  = getStaticGain(file3_09_sg) / 0.9;
staticGains(9)  = getStaticGain(file3_10_sg) / 1.0;
staticGains(10) = getStaticGain(file3_11_sg) / 1.1;
staticGains(11) = getStaticGain(file3_12_sg) / 1.2;

staticGain = mean(staticGains);
