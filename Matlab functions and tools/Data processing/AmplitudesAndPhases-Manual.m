%% get amplitudes from tests 

% fileX_Y_Z, where X = type of experiment, Y = amplitude, Z = frequency)
% X=0 => motor
% X=1 => blocked pendulum, beam moving (X=1c => same w/ cable connected)
% X=2 => blocked beam, pendulum moving
% X=3 => full free system

% getAmplitude(file, frequency) -> outputs position amplitude

file0_02_4  =  load('TestMotor_0.2sin(4).mat');   amp0_02_4   = getAmplitude(file0_02_4, 4);
file0_02_8  =  load('TestMotor_0.2sin(8).mat');   amp0_02_8   = getAmplitude(file0_02_8, 8);
file0_02_16 =  load('TestMotor_0.2sin(16).mat');  amp0_02_16  = getAmplitude(file0_02_16, 16);
file0_02_24 =  load('TestMotor_0.2sin(24).mat');  amp0_02_24  = getAmplitude(file0_02_24, 24);
file0_02_32 =  load('TestMotor_0.2sin(32).mat');  amp0_02_32  = getAmplitude(file0_02_32, 32);

file0_05_7  =  load('TestMotor_0.5sin(7).mat');   amp0_05_7   = getAmplitude(file0_05_7, 7);
file0_05_14 =  load('TestMotor_0.5sin(14).mat');  amp0_05_14  = getAmplitude(file0_05_14, 14);
file0_05_21 =  load('TestMotor_0.5sin(21).mat');  amp0_05_21  = getAmplitude(file0_05_21, 21);
file0_05_28 =  load('TestMotor_0.5sin(28).mat');  amp0_05_28  = getAmplitude(file0_05_28, 28);

file0_1_1   =  load('TestMotor_1sin(1).mat');     amp0_1_1    = getAmplitude(file0_1_1, 1);
file0_1_2   =  load('TestMotor_1sin(2).mat');     amp0_1_2    = getAmplitude(file0_1_2, 2);
file0_1_3   =  load('TestMotor_1sin(3).mat');     amp0_1_3    = getAmplitude(file0_1_3, 3);
file0_1_10  =  load('TestMotor_1sin(10).mat');    amp0_1_10   = getAmplitude(file0_1_10, 10);
file0_1_25  =  load('TestMotor_1sin(25).mat');    amp0_1_25   = getAmplitude(file0_1_25, 25);

file0_2_05  =  load('TestMotor_2sin(0.5).mat');   amp0_2_05   = getAmplitude(file0_2_05, 0.5);
file0_2_1   =  load('TestMotor_2sin(1).mat');     amp0_2_1    = getAmplitude(file0_2_1, 1);
file0_2_2   =  load('TestMotor_2sin(2).mat');     amp0_2_2    = getAmplitude(file0_2_2, 2);
file0_2_3   =  load('TestMotor_2sin(3).mat');     amp0_2_3    = getAmplitude(file0_2_3, 3);
file0_2_5   =  load('TestMotor_2sin(5).mat');     amp0_2_5    = getAmplitude(file0_2_5, 5);
file0_2_15  =  load('TestMotor_2sin(15).mat');    amp0_2_15   = getAmplitude(file0_2_15, 15);
file0_2_25  =  load('TestMotor_2sin(25).mat');    amp0_2_25   = getAmplitude(file0_2_25, 25);

file0_3_1   =  load('TestMotor_3sin(1).mat');     amp0_3_1    = getAmplitude(file0_3_1, 1);
file0_3_2   =  load('TestMotor_3sin(2).mat');     amp0_3_2    = getAmplitude(file0_3_2, 2);
file0_3_3   =  load('TestMotor_3sin(3).mat');     amp0_3_3    = getAmplitude(file0_3_3, 3);

file0_4_03  =  load('TestMotor_4sin(0.3).mat');   amp0_4_03   = getAmplitude(file0_4_03, 0.3);
file0_4_3   =  load('TestMotor_4sin(3).mat');     amp0_4_3    = getAmplitude(file0_4_3, 3);
file0_4_9   =  load('TestMotor_4sin(9).mat');     amp0_4_9    = getAmplitude(file0_4_9, 9);
file0_4_13  =  load('TestMotor_4sin(13).mat');    amp0_4_13   = getAmplitude(file0_4_13, 13);
file0_4_18  =  load('TestMotor_4sin(18).mat');    amp0_4_18   = getAmplitude(file0_4_18, 18);


file1_05_4  =  load('Test1_0.5sin(4).mat');       amp1_05_4   = getAmplitude(file1_05_4, 4);
file1_05_7  =  load('Test1_0.5sin(7).mat');       amp1_05_7   = getAmplitude(file1_05_7, 7);
file1_05_10 =  load('Test1_0.5sin(10).mat');      amp1_05_10  = getAmplitude(file1_05_10, 10);
file1_05_15 =  load('Test1_0.5sin(15).mat');      amp1_05_15  = getAmplitude(file1_05_15, 15);

file1c_05_4  = load('Test1cable_0.5sin(4).mat');  amp1c_05_4  = getAmplitude(file1c_05_4, 4);
file1c_05_7  = load('Test1cable_0.5sin(7).mat');  amp1c_05_7  = getAmplitude(file1c_05_7, 7);
file1c_05_10 = load('Test1cable_0.5sin(10).mat'); amp1c_05_10 = getAmplitude(file1c_05_10, 10);
file1c_05_15 = load('Test1cable_0.5sin(15).mat'); amp1c_05_15 = getAmplitude(file1c_05_15, 15);


file3_03_1  =  load('TestTOT_0.3sin(1).mat');   amp3_03_1   = getAmplitude(file3_03_1, 1);
file3_03_5  =  load('TestTOT_0.3sin(5).mat');   amp3_03_5   = getAmplitude(file3_03_5, 5);
file3_03_12 =  load('TestTOT_0.3sin(12).mat');  amp3_03_12  = getAmplitude(file3_03_12, 12);
file3_03_18 =  load('TestTOT_0.3sin(18).mat');  amp3_03_18  = getAmplitude(file3_03_18, 18);
file3_03_27 =  load('TestTOT_0.3sin(27).mat');  amp3_03_27  = getAmplitude(file3_03_27, 27);
file3_03_37 =  load('TestTOT_0.3sin(37).mat');  amp3_03_37  = getAmplitude(file3_03_37, 37);

file3_05_1  =  load('TestTOT_0.5sin(1).mat');   amp3_05_1   = getAmplitude(file3_05_1, 1);
file3_05_4  =  load('TestTOT_0.5sin(4).mat');   amp3_05_4   = getAmplitude(file3_05_4, 4);
file3_05_7  =  load('TestTOT_0.5sin(7).mat');   amp3_05_7   = getAmplitude(file3_05_7, 7);
file3_05_10 =  load('TestTOT_0.5sin(10).mat');  amp3_05_10  = getAmplitude(file3_05_10, 10);
file3_05_15 =  load('TestTOT_0.5sin(15).mat');  amp3_05_15  = getAmplitude(file3_05_15, 15);
file3_05_25 =  load('TestTOT_0.5sin(25).mat');  amp3_05_25  = getAmplitude(file3_05_25, 25);
file3_05_35 =  load('TestTOT_0.5sin(35).mat');  amp3_05_35  = getAmplitude(file3_05_35, 35);

file3_06_1x1 =  load('TestTOT_0.6sin(1.1).mat'); amp3_06_1x1  = getAmplitude(file3_06_1x1, 1.1);

file3_07_2x2 =  load('TestTOT_0.7sin(2.2).mat'); amp3_07_2x2  = getAmplitude(file3_07_2x2, 2.2);
file3_07_2x4 =  load('TestTOT_0.7sin(2.4).mat'); amp3_07_2x4  = getAmplitude(file3_07_2x4, 2.4);
file3_07_2x6 =  load('TestTOT_0.7sin(2.6).mat'); amp3_07_2x6  = getAmplitude(file3_07_2x6, 2.6);
file3_07_2x8 =  load('TestTOT_0.7sin(2.8).mat'); amp3_07_2x8  = getAmplitude(file3_07_2x8, 2.8);
file3_07_3   =  load('TestTOT_0.7sin(3).mat');   amp3_07_3    = getAmplitude(file3_07_3, 3);
file3_07_3x3 =  load('TestTOT_0.7sin(3.3).mat'); amp3_07_3x3  = getAmplitude(file3_07_3x3, 3.3);
file3_07_3x6 =  load('TestTOT_0.7sin(3.6).mat'); amp3_07_3x6  = getAmplitude(file3_07_3x6, 3.6);

file3_08_1   =  load('TestTOT_0.8sin(1).mat');   amp3_08_1    = getAmplitude(file3_08_1, 1);
file3_08_1x2 =  load('TestTOT_0.8sin(1.2).mat'); amp3_08_1x2  = getAmplitude(file3_08_1x2, 1.2);
file3_08_1x3 =  load('TestTOT_0.8sin(1.3).mat'); amp3_08_1x3  = getAmplitude(file3_08_1x3, 1.3);
file3_08_1x4 =  load('TestTOT_0.8sin(1.4).mat'); amp3_08_1x4  = getAmplitude(file3_08_1x4, 1.4);
file3_08_1x5 =  load('TestTOT_0.8sin(1.5).mat'); amp3_08_1x5  = getAmplitude(file3_08_1x5, 1.5);
file3_08_1x6 =  load('TestTOT_0.8sin(1.6).mat'); amp3_08_1x6  = getAmplitude(file3_08_1x6, 1.6);
file3_08_1x7 =  load('TestTOT_0.8sin(1.7).mat'); amp3_08_1x7  = getAmplitude(file3_08_1x7, 1.7);
file3_08_1x8 =  load('TestTOT_0.8sin(1.8).mat'); amp3_08_1x8  = getAmplitude(file3_08_1x8, 1.8);
file3_08_1x9 =  load('TestTOT_0.8sin(1.9).mat'); amp3_08_1x9  = getAmplitude(file3_08_1x9, 1.9);
file3_08_2   =  load('TestTOT_0.8sin(2).mat');   amp3_08_2    = getAmplitude(file3_08_2, 2);
file3_08_4   =  load('TestTOT_0.8sin(4).mat');   amp3_08_4    = getAmplitude(file3_08_4, 4);
file3_08_10  =  load('TestTOT_0.8sin(10).mat');  amp3_08_10   = getAmplitude(file3_08_10, 10);
file3_08_17  =  load('TestTOT_0.8sin(17).mat');  amp3_08_17   = getAmplitude(file3_08_17, 17);

file3_1_4   =  load('TestTOT_1sin(4).mat');     amp3_1_4    = getAmplitude(file3_1_4, 4);
file3_1_9   =  load('TestTOT_1sin(9).mat');     amp3_1_9    = getAmplitude(file3_1_9, 9);
file3_1_15  =  load('TestTOT_1sin(15).mat');    amp3_1_15   = getAmplitude(file3_1_15, 15);
file3_1_21  =  load('TestTOT_1sin(21).mat');    amp3_1_21   = getAmplitude(file3_1_21, 21);

file3_2_6    =  load('TestTOT_2sin(6).mat');     amp3_2_6    = getAmplitude(file3_2_6, 6);
file3_2_9x8  =  load('TestTOT_2sin(9.8).mat');   amp3_2_9x8  = getAmplitude(file3_2_9x8, 9.8);
file3_2_10   =  load('TestTOT_2sin(10).mat');    amp3_2_10   = getAmplitude(file3_2_10, 10);
file3_2_10x3 =  load('TestTOT_2sin(10.3).mat');  amp3_2_10x3 = getAmplitude(file3_2_10x3, 10.3);
file3_2_10x7 =  load('TestTOT_2sin(10.7).mat');  amp3_2_10x7 = getAmplitude(file3_2_10x7, 10.7);
file3_2_11   =  load('TestTOT_2sin(11).mat');    amp3_2_11   = getAmplitude(file3_2_11, 11);
file3_2_11x5 =  load('TestTOT_2sin(11.5).mat');  amp3_2_11x5 = getAmplitude(file3_2_11x5, 11.5);
% file3_2_12   =  load('TestTOT_2sin(12).mat');    amp3_2_12   = getAmplitude(file3_2_12, 12);
file3_2_12x5 =  load('TestTOT_2sin(12.5).mat');  amp3_2_12x5 = getAmplitude(file3_2_12x5, 12.5);
file3_2_13   =  load('TestTOT_2sin(13).mat');    amp3_2_13   = getAmplitude(file3_2_13, 13);
file3_2_13x5 =  load('TestTOT_2sin(13.5).mat');  amp3_2_13x5 = getAmplitude(file3_2_13x5, 13.5);
file3_2_16   =  load('TestTOT_2sin(16).mat');    amp3_2_16   = getAmplitude(file3_2_16, 16);
file3_2_22   =  load('TestTOT_2sin(22).mat');    amp3_2_22   = getAmplitude(file3_2_22, 22);
file3_2_30   =  load('TestTOT_2sin(30).mat');    amp3_2_30   = getAmplitude(file3_2_30, 30);

file3_4_8   =  load('TestTOT_4sin(8).mat');     amp3_4_8    = getAmplitude(file3_4_8, 8);
file3_4_20  =  load('TestTOT_4sin(20).mat');    amp3_4_20   = getAmplitude(file3_4_20, 20);
file3_4_30  =  load('TestTOT_4sin(30).mat');    amp3_4_30   = getAmplitude(file3_4_30, 30);
file3_4_40  =  load('TestTOT_4sin(40).mat');    amp3_4_40   = getAmplitude(file3_4_40, 40);

% file3_5_14  =  load('TestTOT_5sin(14).mat');    amp3_5_14   = getAmplitude(file3_5_14, 14);
file3_5_24  =  load('TestTOT_5sin(24).mat');    amp3_5_24   = getAmplitude(file3_5_24, 24);
file3_5_34  =  load('TestTOT_5sin(34).mat');    amp3_5_34   = getAmplitude(file3_5_34, 34);
file3_5_44  =  load('TestTOT_5sin(44).mat');    amp3_5_44   = getAmplitude(file3_5_44, 44);


%% get phases

phi0_02_4   = getPhase(file0_02_4, amp0_02_4, 4);
phi0_02_8   = getPhase(file0_02_8, amp0_02_8, 8);
phi0_02_16  = getPhase(file0_02_16, amp0_02_16, 16);
phi0_02_24  = getPhase(file0_02_24, amp0_02_24, 24);
phi0_02_32  = getPhase(file0_02_32, amp0_02_32, 32);

phi0_05_7   = getPhase(file0_05_7, amp0_05_7, 7);
phi0_05_14  = getPhase(file0_05_14, amp0_05_14, 14);
phi0_05_21  = getPhase(file0_05_21, amp0_05_21, 21);
phi0_05_28  = getPhase(file0_05_28, amp0_05_28, 28);

phi0_1_1    = getPhase(file0_1_1, amp0_1_1, 1);
phi0_1_2    = getPhase(file0_1_2, amp0_1_2, 2);
phi0_1_3    = getPhase(file0_1_3, amp0_1_3, 3);
phi0_1_10   = getPhase(file0_1_10, amp0_1_10, 10);
phi0_1_25   = getPhase(file0_1_25, amp0_1_25, 25);

phi0_2_05   = getPhase(file0_2_05, amp0_2_05, 0.5);
phi0_2_1    = getPhase(file0_2_1, amp0_2_1, 1);
phi0_2_2    = getPhase(file0_2_2, amp0_2_2, 2);
phi0_2_3    = getPhase(file0_2_3, amp0_2_3, 3);
phi0_2_5    = getPhase(file0_2_5, amp0_2_5, 5);
phi0_2_15   = getPhase(file0_2_15, amp0_2_15, 15);
phi0_2_25   = getPhase(file0_2_25, amp0_2_25, 25);

phi0_3_1    = getPhase(file0_3_1, amp0_3_1, 1);
phi0_3_2    = getPhase(file0_3_2, amp0_3_2, 2);
phi0_3_3    = getPhase(file0_3_3, amp0_3_3, 3);

phi0_4_03   = getPhase(file0_4_03, amp0_4_03, 0.3);
phi0_4_3    = getPhase(file0_4_3, amp0_4_3, 3);
phi0_4_9    = getPhase(file0_4_9, amp0_4_9, 9);
phi0_4_13   = getPhase(file0_4_13, amp0_4_13, 13);
phi0_4_18   = getPhase(file0_4_18, amp0_4_18, 18);


phi1_05_4   = getPhase(file1_05_4, amp1_05_4, 4);
phi1_05_7   = getPhase(file1_05_7, amp1_05_7, 7);
phi1_05_10  = getPhase(file1_05_10, amp1_05_10, 10);
phi1_05_15  = getPhase(file1_05_15, amp1_05_15, 15);  

phi1c_05_4  = getPhase(file1c_05_4, amp1c_05_4, 4);
phi1c_05_7  = getPhase(file1c_05_7, amp1c_05_7, 7);
phi1c_05_10 = getPhase(file1c_05_10, amp1c_05_10, 10);
phi1c_05_15 = getPhase(file1c_05_15, amp1c_05_15, 15);


phi3_03_1   = getPhase(file3_03_1, amp3_03_1, 1);
phi3_03_5   = getPhase(file3_03_5, amp3_03_5, 5);
phi3_03_12  = getPhase(file3_03_12, amp3_03_12, 12);
phi3_03_18  = getPhase(file3_03_18, amp3_03_18, 18);
phi3_03_27  = getPhase(file3_03_27, amp3_03_27, 27);
phi3_03_37  = getPhase(file3_03_37, amp3_03_37, 37);

phi3_05_1   = getPhase(file3_05_1, amp3_05_1, 1);
phi3_05_4   = getPhase(file3_05_4, amp3_05_4, 4);
phi3_05_7   = getPhase(file3_05_7, amp3_05_7, 7);
phi3_05_10  = getPhase(file3_05_10, amp3_05_10, 10);
phi3_05_15  = getPhase(file3_05_15, amp3_05_15, 15);
phi3_05_25  = getPhase(file3_05_25, amp3_05_25, 25);
phi3_05_35  = getPhase(file3_05_35, amp3_05_35, 35);

phi3_06_1x1  = getPhase(file3_06_1x1, amp3_06_1x1, 1.1);

phi3_07_2x2  = getPhase(file3_07_2x2, amp3_07_2x2, 2.2);
phi3_07_2x4  = getPhase(file3_07_2x4, amp3_07_2x4, 2.4);
phi3_07_2x6  = getPhase(file3_07_2x6, amp3_07_2x6, 2.6);
phi3_07_2x8  = getPhase(file3_07_2x8, amp3_07_2x8, 2.8);
phi3_07_3    = getPhase(file3_07_3, amp3_07_3, 3);
phi3_07_3x3  = getPhase(file3_07_3x3, amp3_07_3x3, 3.3);
phi3_07_3x6  = getPhase(file3_07_3x6, amp3_07_3x6, 3.6);

phi3_08_1    = getPhase(file3_08_1, amp3_08_1, 1);
phi3_08_1x2  = getPhase(file3_08_1x2, amp3_08_1x2, 1.2);
phi3_08_1x3  = getPhase(file3_08_1x3, amp3_08_1x3, 1.3);
phi3_08_1x4  = getPhase(file3_08_1x4, amp3_08_1x4, 1.4);
phi3_08_1x5  = getPhase(file3_08_1x5, amp3_08_1x5, 1.5);
phi3_08_1x6  = getPhase(file3_08_1x6, amp3_08_1x6, 1.6);
phi3_08_1x7  = getPhase(file3_08_1x7, amp3_08_1x7, 1.7);
phi3_08_1x8  = getPhase(file3_08_1x8, amp3_08_1x8, 1.8);
phi3_08_1x9  = getPhase(file3_08_1x9, amp3_08_1x9, 1.9);
phi3_08_2    = getPhase(file3_08_2, amp3_08_2, 2);
phi3_08_4    = getPhase(file3_08_4, amp3_08_4, 4);
phi3_08_10   = getPhase(file3_08_10, amp3_08_10, 10);
phi3_08_17   = getPhase(file3_08_17, amp3_08_17, 17);

phi3_1_4    = getPhase(file3_1_4, amp3_1_4, 4);
phi3_1_9    = getPhase(file3_1_9, amp3_1_9, 9);
phi3_1_15   = getPhase(file3_1_15, amp3_1_15, 15);
phi3_1_21   = getPhase(file3_1_21, amp3_1_21, 21);

phi3_2_6    = getPhase(file3_2_6, amp3_2_6, 6);
phi3_2_9x8  = getPhase(file3_2_9x8, amp3_2_9x8, 9.8);
phi3_2_10   = getPhase(file3_2_10, amp3_2_10, 10);
phi3_2_10x3 = getPhase(file3_2_10x3, amp3_2_10x3, 10.3);
phi3_2_10x7 = getPhase(file3_2_10x7, amp3_2_10x7, 10.7);
phi3_2_11   = getPhase(file3_2_11, amp3_2_11, 11);
phi3_2_11x5 = getPhase(file3_2_11x5, amp3_2_11x5, 11.5);
% phi3_2_12   = getPhase(file3_2_12, amp3_2_12, 12);
phi3_2_12x5 = getPhase(file3_2_12x5, amp3_2_12x5, 12.5);
phi3_2_13   = getPhase(file3_2_13, amp3_2_13, 13);
phi3_2_13x5 = getPhase(file3_2_13x5, amp3_2_13x5, 13.5);
phi3_2_16   = getPhase(file3_2_16, amp3_2_16, 16);
phi3_2_22   = getPhase(file3_2_22, amp3_2_22, 22);
phi3_2_30   = getPhase(file3_2_30, amp3_2_30, 30);

phi3_4_8    = getPhase(file3_4_8, amp3_4_8, 8);
phi3_4_20   = getPhase(file3_4_20, amp3_4_20, 20);
phi3_4_30   = getPhase(file3_4_30, amp3_4_30, 30);
phi3_4_40   = getPhase(file3_4_40, amp3_4_40, 40);

% phi3_5_14   = getAmplitude(file3_5_14, amp3_5_14, 14);
phi3_5_24   = getPhase(file3_5_24, amp3_5_24, 24);
phi3_5_34   = getPhase(file3_5_34, amp3_5_34, 34);
phi3_5_44   = getPhase(file3_5_44, amp3_5_44, 44);




%% compute gains : amplitude / voltage

G0_02_4   = amp0_02_4  / 0.2;
G0_02_8   = amp0_02_8  / 0.2;
G0_02_16  = amp0_02_16 / 0.2;
G0_02_24  = amp0_02_24 / 0.2;
G0_02_32  = amp0_02_32 / 0.2;

G0_05_7   = amp0_05_7  / 0.5;
G0_05_14  = amp0_05_14 / 0.5;
G0_05_21  = amp0_05_21 / 0.5;
G0_05_28  = amp0_05_28 / 0.5;

G0_1_1    = amp0_1_1  / 1;
G0_1_2    = amp0_1_2  / 1;
G0_1_3    = amp0_1_3  / 1;
G0_1_10   = amp0_1_10 / 1;
G0_1_25   = amp0_1_25 / 1;

G0_2_05   = amp0_2_05  / 2;
G0_2_1    = amp0_2_1  / 2;
G0_2_2    = amp0_2_2  / 2;
G0_2_3    = amp0_2_3  / 2;
G0_2_5    = amp0_2_5   / 2;
G0_2_15   = amp0_2_15  / 2;
G0_2_25   = amp0_2_25  / 2;

G0_3_1    = amp0_3_1  / 3;
G0_3_2    = amp0_3_2  / 3;
G0_3_3    = amp0_3_3  / 3;

G0_4_03   = amp0_4_03  / 4;
G0_4_3    = amp0_4_3   / 4;
G0_4_9    = amp0_4_9   / 4;
G0_4_13   = amp0_4_13  / 4;
G0_4_18   = amp0_4_18  / 4;


G1_05_4   = amp1_05_4  / 0.5;
G1_05_7   = amp1_05_7  / 0.5;
G1_05_10  = amp1_05_10 / 0.5;
G1_05_15  = amp1_05_15 / 0.5;

G1c_05_4  = amp1_05_4  / 0.5;
G1c_05_7  = amp1_05_7  / 0.5;
G1c_05_10 = amp1_05_10 / 0.5;
G1c_05_15 = amp1_05_15 / 0.5;


G3_03_1  =  amp3_03_1  / 0.3;
G3_03_5  =  amp3_03_5  / 0.3;
G3_03_12 =  amp3_03_12 / 0.3;
G3_03_18 =  amp3_03_18 / 0.3;
G3_03_27 =  amp3_03_27 / 0.3;
G3_03_37 =  amp3_03_37 / 0.3;

G3_05_1  =  amp3_05_1  / 0.5;
G3_05_4  =  amp3_05_4  / 0.5;
G3_05_7  =  amp3_05_7  / 0.5;
G3_05_10 =  amp3_05_10 / 0.5;
G3_05_15 =  amp3_05_15 / 0.5;
G3_05_25 =  amp3_05_25 / 0.5;
G3_05_35 =  amp3_05_35 / 0.5;

G3_06_1x1  = amp3_06_1x1 / 0.6;

G3_07_2x2  = amp3_07_2x2 / 0.7;
G3_07_2x4  = amp3_07_2x4 / 0.7;
G3_07_2x6  = amp3_07_2x6 / 0.7;
G3_07_2x8  = amp3_07_2x8 / 0.7;
G3_07_3    = amp3_07_3  / 0.7;
G3_07_3x3  = amp3_07_3x3 / 0.7;
G3_07_3x6  = amp3_07_3x6 / 0.7;

G3_08_1    = amp3_08_1  / 0.8;
G3_08_1x2  = amp3_08_1x2 / 0.8;
G3_08_1x3  = amp3_08_1x3 / 0.8;
G3_08_1x4  = amp3_08_1x4 / 0.8;
G3_08_1x5  = amp3_08_1x5 / 0.8;
G3_08_1x6  = amp3_08_1x6 / 0.8;
G3_08_1x7  = amp3_08_1x7 / 0.8;
G3_08_1x8  = amp3_08_1x8 / 0.8;
G3_08_1x9  = amp3_08_1x9 / 0.8;
G3_08_2    = amp3_08_2  / 0.8;
G3_08_4    = amp3_08_4  / 0.8;
G3_08_10   = amp3_08_10 / 0.8;
G3_08_17   = amp3_08_17 / 0.8;

G3_1_4   =  amp3_1_4   / 1;
G3_1_9   =  amp3_1_9   / 1;
G3_1_15  =  amp3_1_15  / 1;
G3_1_21  =  amp3_1_21  / 1;

G3_2_6    =  amp3_2_6   / 2;
G3_2_9x8  =  amp3_2_9x8  / 2;
G3_2_10   =  amp3_2_10  / 2;
G3_2_10x3 =  amp3_2_10x3 / 2;
G3_2_10x7 =  amp3_2_10x7 / 2;
G3_2_11   =  amp3_2_11  / 2;
G3_2_11x5 =  amp3_2_11x5 / 2;
% G3_2_12   =  amp3_2_12  / 2;
G3_2_12x5 =  amp3_2_12x5 / 2;
G3_2_13   =  amp3_2_13  / 2;
G3_2_13x5 =  amp3_2_13x5 / 2;
G3_2_16   =  amp3_2_16  / 2;
G3_2_22   =  amp3_2_22  / 2;
G3_2_30   =  amp3_2_30  / 2;

G3_4_8   =  amp3_4_8   / 4;
G3_4_20  =  amp3_4_20  / 4;
G3_4_30  =  amp3_4_30  / 4;
G3_4_40  =  amp3_4_40  / 4;

% G3_5_14  =  amp3_5_14 / 5;
G3_5_24  =  amp3_5_24  / 5;
G3_5_34  =  amp3_5_34  / 5;
G3_5_44  =  amp3_5_44  / 5;

