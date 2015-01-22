function DOE=DoE_maker_MOD_auto(P_init)
global ScriptDir

ngen=1; %number of gen required in each txt file
nfil=size(P_init,1)/ngen;  %number of files

i=1;
j=0;
for ii=1:40
    j=j+1;
    filename = [ScriptDir,'\..\NextRun\gene', num2str(ii), '.txt'];
    fid=fopen(filename,'a+');
    for jj=1:size(P_init,2)
        fprintf(fid,'%12.6f\n',P_init(i:j,jj));
    end
    i=i+1;
    fclose(fid);
end
DOE=1;

