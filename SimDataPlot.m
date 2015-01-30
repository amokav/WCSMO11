clear
clc
scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
global ScriptDir 
ScriptDir = Sdir;
expData1 = load([ScriptDir,'\..\ExperimentalData\exp1_res.mat']);
ED1 = expData1.exp1_res;
expData2 = load([ScriptDir,'\..\ExperimentalData\exp2_res.mat']);
ED2 = expData2.exp2_res;
ED1=[ED1(:,2),ED1(:,1)];
load([ScriptDir,'\..\Results\archive.mat'])%,'archive','init','F_archive','F_total','P_total','number_of_ND','SimData','F_min','F_max')
gen=size(init,2);
nDoE=number_of_ND(gen).nd_counter;
nplot=ceil(sqrt(nDoE+1));
wexp=0.1;
figure(1)
 for i= 1:nDoE
 x1=SimDataElite(gen).SDi(i).MOD1(:,1);
y1=SimDataElite(gen).SDi(i).MOD1(:,2);
err1(i) = obj_f1([x1,y1],ED1,wexp,0);
subplot(nplot,nplot,i)
    hp1 = plot(x1,y1,'-bo',ED1(:,1),ED1(:,2),'-ro');
    set(hp1, 'MarkerSize', 2)
    title([err1(i)])
   % title(F_archive(gen).F_Pbar_new(i,1))
 end
subplot(nplot,nplot,i+1)
KD1 = load([ScriptDir,'\..\ExperimentalData\kent_mod1.mat']);
KD1 = KD1.kent_DCB_data;
hp = plot(KD1(:,1),KD1(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
set(hp, 'MarkerSize', 2)
errK1 = obj_f1(KD1,ED1,wexp,0);
title([errK1])
 penalty=300;
 figure(2)
 for i= 1:nDoE
 x2=SimDataElite(gen).SDi(i).MOD2(:,1);
y2=SimDataElite(gen).SDi(i).MOD2(:,2);
err2(i) = obj_f2([x2,y2],ED2,0);
subplot(nplot,nplot,i)
    hp2 = plot(x2,y2,'-bo',ED2(:,1),ED2(:,2),'-ro');
    set(hp2, 'MarkerSize', 2)
     title([err2(i)])
    %title(F_archive(gen).F_Pbar_new(i,2))
 end 
subplot(nplot,nplot,i+1)
KD2 = load([ScriptDir,'\..\ExperimentalData\kent_mod2.mat']);
KD2 = KD2.fem_enf_data;
hp = plot(KD2(:,1),KD2(:,2),'-bo',ED2(:,1),ED2(:,2),'-ro');
set(hp, 'MarkerSize', 2)
errK2 = obj_f2(KD2,ED2,0);
title([errK2])
