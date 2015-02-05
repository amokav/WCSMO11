function [ output_args ] = ParetoMovieInteractive( input_args )
%PARETOMOVIEINTERACTIVE Summary of this function goes here
%   Detailed explanation goes here
try
    close(69)
end
%%
scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
ScriptDir = Sdir;

%% Data
% N = 100;
% n = 40;
% A(N).F = [0,0];
% for i = 1:N
%     A(i).F = rand(n,2);
% end
A = load([ScriptDir,'\..\Results\archive BeforeObjChange.mat']);
AF = A.F_archive
ND = A.number_of_ND;


KentData = load([ScriptDir,'\..\Results\KentInfo.mat']);

%% Videowriter
% writerobj=VideoWriter('Pareto3.avi','Motion JPEG AVI' );
% writerobj.FrameRate=4;
% writerobj.Quality = 100;
% open(writerobj)

%% Kents image
img = imread('kent.jpg');

%% Kents Data
F_Kent = KentData.FKent;


%% Loop over solutions
xfigure(69); hold on;
dx = 0.0005; dy = 0;

N = length(AF);

for i = 1:N
    Fall = AF(i).F_Pbar_new;
    nd = ND(i).nd_counter;
    F = Fall(1:nd,:);
    np = size(F,1);
    if i == 1
        hPlots1 = plot(F(:,1),F(:,2),'bo','linewidth',1.5,'markersize',3,'MarkerFaceColor','b');
        
        hPlots2 = plot(F_Kent(1),F_Kent(2),'ro','linewidth',1.5,'markersize',3,'MarkerFaceColor','r');
        xlabel('f1');
        ylabel('f2');
        
    else
        try
            delete(PLabel1)
            delete(hPlots1)
        end
        PLabel1 = zeros(np,1);
        for j = 1:np
            PLabel1(j) = text(F(j,1)+dx, F(j,2)+dy, num2str(j),'Fontsize',8) ;
        end
        
        title(['MOOP Project -Iteration: ',num2str(i)])
        if i = 124
            size(F)
            
        end
        hPlots1 = plot(F(:,1),F(:,2),'bo','linewidth',1.5,'markersize',3,'MarkerFaceColor','b');

%         writeVideo(writerobj,getframe(1))

    end
    
    
end
% close(writerobj)

set(69,'KeyPressFcn',@KeyPressFcn)

    function KeyPressFcn(src,evnt)
        xfigure_KPF(src, evnt);
        
        if strcmp(evnt.Key,'leftarrow')
            if i > 1
                i = i-1;
                
                Fall = AF(i).F_Pbar_new;
                nd = ND(i).nd_counter;
                F = Fall(1:nd,:);
                np = size(F,1);
                
                title(['MOOP Project -Iteration: ',num2str(i)])
                
                
                try
                    delete(PLabel1)
                    delete(hPlots1)
                end
                hPlots1 = plot(F(:,1),F(:,2),'bo','linewidth',1.5,'markersize',3,'MarkerFaceColor','b');
                PLabel1 = zeros(np,1);
                for j = 1:np
                    PLabel1(j) = text(F(j,1)+dx, F(j,2)+dy, num2str(j),'Fontsize',8) ;
                end
            end
        elseif strcmp(evnt.Key,'rightarrow')
            if i < N-1
                i = i+1;
                
                Fall = AF(i).F_Pbar_new;
                nd = ND(i).nd_counter;
                F = Fall(1:nd,:);
                np = size(F,1);
                
                title(['MOOP Project -Iteration: ',num2str(i)])
                hPlots1.XData = F(:,1);
                hPlots1.YData = F(:,2);
                
                try
                    delete(PLabel1)
                    delete(hPlots1)
                end
                hPlots1 = plot(F(:,1),F(:,2),'bo','linewidth',1.5,'markersize',3,'MarkerFaceColor','b');
                PLabel1 = zeros(np,1);
                for j = 1:np
                    PLabel1(j) = text(F(j,1)+dx, F(j,2)+dy, num2str(j),'Fontsize',8) ;
                end
            end
        end
        
        
    end

end



