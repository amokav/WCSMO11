clear all

scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
ScriptDir = Sdir;
expData1 = load([ScriptDir,'\..\ExperimentalData\exp1_res.mat']);
ED1 = expData1.exp1_res;
expData2 = load([ScriptDir,'\..\ExperimentalData\exp2_res.mat']);
ED2 = expData2.exp2_res;
ED1=[ED1(:,2),ED1(:,1)];
load([ScriptDir,'\..\Results\archive BeforeObjChange.mat'])

nF = 40*(4+4);
F1 = zeros(nF,1);
F2 = zeros(nF,1);
c = 1;
wexp=0.1;
for ig = 120:123
    for ip = 1:40
        SD1 = [SimData(ig).SDi(ip).MOD1];
        F1(c) = obj_f1(SD1,ED1,wexp);
        SD(c).SD1=SD1;
                c = c+1;
    end  
end
for ig = 120:123
    for ip = 1:40
        SD1 = [SimDataElite(ig).SDi(ip).MOD1];
        F1(c) = obj_f1(SD1,ED1,wexp);
        SD(c).SD1=SD1;
        c = c+1;
    end  
end

c = 1;
for ig = 120:123
    for ip = 1:40
        SD2 = [SimData(ig).SDi(ip).MOD2];
        F2(c) = obj_f1(SD2,ED2,wexp);
         SD(c).SD2=SD2;
        c = c+1;
    end  
end
for ig = 120:123
    for ip = 1:40
        SD2 = [SimDataElite(ig).SDi(ip).MOD2];
        F2(c) = obj_f1(SD2,ED2,wexp);
        SD(c).SD2=SD2;
        c = c+1;
    end  
end

FF=[F1,F2];

%save('ObjectiveFunctions','F1','F2')
