function MOD = readResultData(filename,viz)
clc
fid = fopen(filename);
tline = fgetl(fid);
ig = 0;
cstrain = 0;
cstress = 0;
line = 0;
while ischar(tline)
    line = line+1;
    %sig value
    i1 = strfind(tline, 'sig=')+4;
    i2 = strfind(tline, ', lam2=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).sig = str2double(tline(i1:i2));       
    end

    %lam2 value
    i1 = strfind(tline, 'lam2=')+5;
    i2 = strfind(tline, ', sigh=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).lam2 = str2double(tline(i1:i2));
    end
    
    %sigh value
    i1=strfind(tline, 'sigh=')+5;
    i2=strfind(tline, ', delnc=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).sigh=str2double(tline(i1:i2));
    end
    
    %     delnc value
    i1=strfind(tline, 'delnc=')+6;
    i2=strfind(tline, ', deltc=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).delnc=str2double(tline(i1:i2));
    end
    
    %deltc value
    i1=strfind(tline, 'deltc=')+6;
    i2=strfind(tline, ', lam2_g=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).deltc=str2double(tline(i1:i2));
    end
    
    %lam2_g
    i1=strfind(tline, 'lam2_g=')+7;
    i2=strfind(tline, ', sigh_g=')-1;
    if ~isempty (i1) && ~isempty(i2)
        MOD(ig+1).lam2_g=str2double(tline(i1:i2));
    end
    %sigh_g
    i1=strfind(tline, 'sigh_g=')+7;
    i2=strfind(tline, ', delnc_g=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).sigh_g=str2double(tline(i1:i2));
    end
    %delnc_g
    i1=strfind(tline, 'delnc_g=')+8;
    i2=strfind(tline, ', deltc_g=')-1;
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).delnc_g=str2double(tline(i1:i2));
    end
    %deltc_g
    i1=strfind(tline, 'deltc_g=')+8;
    i2=strfind(tline, ' ');
    if ~isempty(i1) && ~isempty(i2)
        MOD(ig+1).deltc=str2double(tline(i1:end));
    end
    
    i1 = strfind(tline, '0.0000E+00');
    i2 = strfind(tline, ' ');
    if ~isempty(i1) && ~isempty(i2)
        ig = ig+1;
        cstrain = 0;
        cstress = 0;
    end
    
    i1 = strfind(tline, 'sig=');
    if isempty(i1) && ~strcmpi(tline,'') && ~strcmpi(tline,'abort') %second condition checks for spaces
        cstrain = cstrain +1;
        cstress = cstress +1;
        i2 = strfind(tline, ' ');
        strain1 = str2double(tline(1:i2));
        stress1 = str2double(tline(i2+1:end));
        MOD(ig).strain(cstrain) = strain1;
        MOD(ig).stress(cstress) = stress1;
    elseif isempty(i1) && ~strcmpi(tline,'') && strcmpi(tline,'abort') 
        MOD(ig).abort='abort';
                
    end
    
    
    tline = fgetl(fid);
end
fclose(fid);


for i = 1:ig
    MOD(i).strain =  MOD(i).strain';
    MOD(i).stress =  MOD(i).stress';
end

if viz
    h = figure;
    for i = 1:length(MOD)
        subplot(5,4,i)
        plot(MOD(i).strain,MOD(i).stress,'-bo')
    end
end

