function f2=ObjFcnDev2_auto(filename)
global ScriptDir
expData2 = load([ScriptDir,'\..\ExperimentalData\exp2_res.mat']);
ED1 = expData2.exp2_res;
MOD2 = readResultData(filename,0);
if ~isfield(MOD2(1),'abort')
    MOD2(1).abort=[];
end

nG = length(MOD2);
nplot=ceil(sqrt(nG+1));
%xfigure
 figure(2)
penalty=300;
for ig = 1:nG
    SDi = [MOD2(ig).strain, MOD2(ig).stress];
    err(ig) = obj_f2(SDi,ED1,0.07);
        if ~isempty(MOD2(ig).abort)   %adds a penalty to objective if the abaqus was aborted becuase it exceded the max stress
        err(ig) = obj_f2(SDi,ED1,0.07)+penalty;  
        end
    subplot(nplot,nplot,ig)
    hp = plot(SDi(:,1),SDi(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
    set(hp, 'MarkerSize', 2)
    title([err(ig)])
end
subplot(nplot,nplot,ig+1)
KD1 = load([ScriptDir,'\..\ExperimentalData\kent_mod2.mat']);
KD1 = KD1.fem_enf_data;
hp = plot(KD1(:,1),KD1(:,2),'-bo',ED1(:,1),ED1(:,2),'-ro');
set(hp, 'MarkerSize', 2)
errK = obj_f2(KD1,ED1,0);
title([errK])
f2=err';







