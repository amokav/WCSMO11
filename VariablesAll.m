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
V = zeros(nF,9);

c = 1;
for ig = 120:123
    for ip = 1:40
        V(c,:) = init(ig).P_init(ip,:);
        c = c+1;
    end  
end
for ig = 120:123
    for ip = 1:40
        V(c,:) = archive(ig).P_bar(ip,:);
        c = c+1;
    end  
end


V;

%save('Variables','V')
