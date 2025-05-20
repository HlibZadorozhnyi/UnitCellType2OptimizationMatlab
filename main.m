%% 基于粒子群工具箱的函数优化算法

%% 清空环境
clear
clc

% global function_evaluation 
% function_evaluation=0;

%% 参数初始化
par_min=0.1*ones(1,7); %ì³í³ìàëüí³ çíà÷åííÿ ïàðàìåòð³â
par_max=2*ones(1,7); %ìàêñèìàëüí³ çíà÷åííÿ ïàðàìåòð³â
varrange=[par_min' par_max']; 

dims=length(par_min);




function_name = 'singleRun'; %ö³ëüîâà ôóíêö³ÿ
plotfcn='goplotpso'; % ôóíêö³ÿ â³äîáðàæåííÿ ïîòî÷íî¿ ñòàòèñòèêè
minmax=0; % 0 - ì³í³ì³çàö³ÿ; 1 - ìàêñèì³çàö³ÿ
modl=1; %0 = íàëàøòóâàííÿ àëãîðèòìó ïàðàìåòðàìè ac, Iwt, wt_end; 1= ïàðàìåòðè Òðåëåà; 2   = ïàðàìåòðè Êëåðêà
ps=20; % ê³ëüê³òü îñîáèí ó ðî¿

mvden=7;

mv=[];
for i=1:dims
    mv=[mv; (varrange(i,2)-varrange(i,1))/mvden];
end

mv = ones(7,1);


%% PSO parameters
shw     = 1;   % how often to update display
ac      = [2.1,2.1];% acceleration constants, only used for modl=0
Iwt     = [0.9,0.6];  % intertia weights, only used for modl=0
epoch   = 10; % ìàêñèìàëüíà ê³ëüê³ñòü ³òåðàö³é
wt_end  = 20; % iterations it takes to go from Iwt(1) to Iwt(2), only for modl=0
errgrad = 0.001;   % óìîâè çóïèíêè ïî âåëè÷èí³ çì³íè ÖÔ
errgoal=0; % óìîâà çóïèíêè ïî çíà÷åííþ ÖÔ
errgraditer=10; % ìàêñèìàëüíà ê³ëüê³ñòü åïîõ äëÿ â³äñóòíîñò³ çì³íè ÖÔ < errgrad
PSOseed = 0;    % if=1 then can input particle starting positions, if= 0 then all random
BoundaryType=1; %0) íåâèäèì³ ìåæ³, 1) ïîãëèíàþ÷³ ìåæ³,
       %         2) àìîðòèçóþ÷³ ìåæ³ ,    3) â³äáèâàþ÷³ ìåæ³

  psoparams=...
   [shw epoch ps ac(1) ac(2) Iwt(1) Iwt(2) ...
    wt_end errgrad errgraditer errgoal modl PSOseed BoundaryType];




%% PSO run

    [pso_out,tr,te]=pso_Trelea_vectorized(function_name, dims,...
      mv, varrange, minmax, psoparams,plotfcn);


function_evaluation_max=function_evaluation

load PSO_particles.mat

%% 粒子群寻优
% pso_Trelea_vectorized('rangeRun',n,Max_V/5,range,0,PSOparams)  %调用PSO核心模块




% Wline = 1;
% Wgap =  [0.95 0.85 0.75 0.65 0.55 0.45 0.4 0.45 0.55 0.65 0.75 0.85 0.95];
% 
% path_CST = 'C:\Program Files (x86)\CST Studio Suite 2024\AMD64\CST DESIGN ENVIRONMENT_AMD64.exe';
% singleRun([Wline, Wgap]);


