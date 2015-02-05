 clc
clear
close all
%number of variables
M=9;
%Number of initial population
N=40;
% Archive size
N_bar=40;

%Objective Functions to be Minimized
n_F=2;
% Normalized inequality constraints
G=[];
% Normalized equality constraints
H=[];
%Lower and Upper bounds
xL=[45;0.1;20;45e-3;20e-3;0.1;9;10e-3;30e-3];
xU=[55;0.8;25;80e-3;60e-3;0.8;11;60e-3;100e-3];


scriptPath = mfilename('fullpath');
[Sdir,~,~] = fileparts(scriptPath);
global ScriptDir 
ScriptDir = Sdir;


f_counter=0;
Counter=1;
nfilMOD1=40;
nfilMOD2=40;
viz=0;
%Counter for contorling number of generations
%for Counter=1:2
%while  f_counter<1

disp('Doing MOOP magic... please wait....')

load([ScriptDir,'\..\Results\archive.mat'])
n_archive=size(init,2);
P_init=init(n_archive).P_init;
P_bar=archive(n_archive).P_bar;
F_Pbar_new=F_archive(n_archive).F_Pbar_new;



%% Creating Set P, by adding the two sets P_init (initial population) and

 P(1:length(P_init),:)=P_init;
%F=CalcObj_plot(nfilMOD1,nfilMOD1,viz);
[Finit, SDi]=CalcObj(nfilMOD1,nfilMOD1,viz);
 F(1:length(P_init),:)=Finit;
%SimDataElite(n_archive).SDi=SDi;
SimData(n_archive).SDi=SDi; 

if length(P_bar)~=0
    for i=length(P_init)+1:length(P_init)+length(P_bar)
        P(i,:)=P_bar(i-length(P_init),:);
        F(i,:)=F_Pbar_new(i-length(P_init),:);
    end
 end
SDi(1,length(P_init)+1:length(P_init)+length(P_bar),:)=SimDataElite(n_archive).SDi;

for i=1:length(P)
    %% Number of individuals that dominate this individual
    N_dominatedby(i)=0;
    %Number of individuals that this individual dominate
    N_dominates(i)=0;
    %Individuals which this individual dominate
    dominates(i).solutions=[];
    %Individuals which dominate this individual
    dominated(i).bysolutions=[];
    %%
    for j=1:length(P)
        ndom_less=0;
        ndom_equal=0;
        ndom_more=0;
        Fi=F(i,:);
        Fj=F(j,:);
        if i~=j
            for k=1:n_F
                %%  Searching for F_min and F_max  %%%%%%
                if i==1;
                    if Fj(k)<F_min(k)
                        F_min(k)=Fj(k);
                    elseif Fj(k)>F_max(k)
                        F_max(k)=Fj(k);
                    end
                end
                %%
                if Fi(k)< Fj(k)
                    ndom_less=ndom_less+1;
                elseif Fi(k)== Fj(k)
                    ndom_equal=ndom_equal+1;
                else
                    ndom_more=ndom_more+1;
                end
            end
        else
            continue
        end
        if ndom_less==0 && ndom_equal~=n_F
            N_dominatedby(i)=N_dominatedby(i)+1;
            dominated(i).bysolutions=[dominated(i).bysolutions j];
        elseif ndom_more==0 && ndom_equal~= n_F
            N_dominates(i)=N_dominates(i)+1;
            dominates(i).solutions=[dominates(i).solutions j];
        end
    end
end
R=zeros;
Fitness=zeros;
nd_counter=0;
F_Pbar_new=[];
Fit_Pbar_new=[];

for i=1:length(P)
    R(i)=0;
    for j=1:length(dominated(i).bysolutions)
        R(i)=N_dominates(dominated(i).bysolutions(j))+R(i);
    end
end
Kth=round(sqrt(N+N_bar));
%%%%%%%%% Creating the upper diagonal part of distance matrix %%%%%%%%%%%
n_vector=1;
d_vector=zeros(1,(length(P)*length(P)-length(P))/2);
for i=1:length(P)
    for j=1:length(P)
        Fi=F(i,:);
        Fj=F(j,:);
        if j>i
            d=0;
            for k=1:n_F
                d=d+((Fi(k)-Fj(k))/(F_max(k)-F_min(k)))^2 ;
            end
            d_vector(n_vector)=sqrt(d);
            n_vector=n_vector+1;
        end
    end
end
%%%%%%%%%%%%%Creating distance matrix from the created upper diagonal matrix
%%%%%% by filling the digonal by zeros and lower diagonal part
filler = 0 ;
NN = ceil(sqrt(2*numel(d_vector))) ;
dist = zeros(NN) ;
dist(tril(true(NN),-1)) = d_vector ;
dist = dist + dist.' + eye(NN) * filler;
%%%% Assigning fitness to each solution in P, and creating the new P_bar set
%%%% with the non-dominated solutions with Fitness<1
for i=1:length(P)
    d_sort=sort(dist(i,:));
    Fitness(i,1)=R(i)+1/(d_sort(Kth)+2);
    if Fitness(i)<1
        nd_counter=nd_counter+1;
        Pbar_new(nd_counter,:)=P(i,:);
        F_Pbar_new(nd_counter,:)=F(i,:);
        Fit_Pbar_new(nd_counter,:)=Fitness(i,:);
        SDi_new(1,nd_counter)=SDi(1,i);
    end
end
%%% if the number of non-Dominated solutions is less than the archive
%%% (P_bar)size (N_bar), the archive will be filled with nominated solutions
%%% having best fitness
if nd_counter<N_bar
    [sort_Fitness indice_sortFitness]=sort(Fitness);
    best_nominated= find(sort_Fitness>=1,N_bar-nd_counter);
    for i=1:length(best_nominated)
        Pbar_new(i+nd_counter,:)=P(indice_sortFitness(best_nominated(i)),:);
        F_Pbar_new(i+nd_counter,:)=F(indice_sortFitness(best_nominated(i)),:);
        Fit_Pbar_new(i+nd_counter,:)=Fitness(indice_sortFitness(best_nominated(i)),:);
        SDi_new(1,i+nd_counter)=SDi(1,indice_sortFitness(best_nominated(i)));
    end
    %%% if the number of non-Dominated solutions is more than the archive
    %%% (P_bar)size (N_bar), the excessive non-dominated solutions will be deleted by means of truncation.
elseif nd_counter>N_bar
    %%%%%%%% Creating the upper diagonal part of distance matrix of P_bar %%%%%%%%%%%
    n_distance_vector=1;
    distance_vector=zeros(1,(length(Pbar_new)*length(Pbar_new)-length(Pbar_new))/2);
    for i=1:length(Pbar_new)
        for j=1:length(Pbar_new)
            Fi=F_Pbar_new(i,:);
            Fj=F_Pbar_new(j,:);
            if j>i
                distance_init=0;
                for k=1:n_F
                    distance_init=distance_init+((Fi(k)-Fj(k))/(F_max(k)-F_min(k)))^2 ;
                end
                distance_vector(n_distance_vector)=sqrt(distance_init);
                n_distance_vector=n_distance_vector+1;
            end
        end
    end
    %%%%%%%%%%%%Creating distance matrix from the created upper diagonal matrix
    %%%%% by filling the digonal by zeros and lower diagonal part
    filler = 0 ;
    MM = ceil(sqrt(2*numel(distance_vector))) ;
    distance = zeros(MM) ;
    distance(tril(true(MM),-1)) = distance_vector ;
    distance = distance + distance.' + eye(MM) * filler;
    %%%%% reducing the n_elimination number if excessive solutions from
    %%%%% P_bar by trunction
    n_elimination=nd_counter-N_bar;
    [Pbar_new, Fit_Pbar_new, F_Pbar_new,SDi_new]=trunction1(N,Pbar_new,distance,Fit_Pbar_new,F_Pbar_new,SDi_new,n_elimination);
end
%%%Applying Tournament Selection on Pbar_new to create mating pool
pool_size=N_bar;
tour_size=2;
population_selection=Pbar_new;
Fit=Fit_Pbar_new;
mating_pool=Tournament_Selection(population_selection,pool_size,tour_size,Fit);
%%%Applying genetic operators on Pbar_new to create P_init
parent= mating_pool;
children=genetic_operator(parent,N,N_bar,M,xU,xL);
P_init=children(1:N_bar,:);
P_bar=Pbar_new;
n_archive=n_archive+1;
archive(n_archive).P_bar=P_bar;
init(n_archive).P_init=P_init;
F_archive(n_archive).F_Pbar_new=F_Pbar_new;
F_total(n_archive).F=F;
P_total(n_archive).P=P;
number_of_ND(n_archive).nd_counter=nd_counter;
%SimData(n_archive).SDi=SDi(1:40); 
SimDataElite(n_archive).SDi=SDi_new; 
% 
  save([ScriptDir,'\..\Results\archive.mat'],'archive','init','F_archive','F_total','P_total','number_of_ND','SimData','SimDataElite','F_min','F_max')
    DOE=DoE_maker_MOD_auto(P_init);
% % 
% % 
 exit
