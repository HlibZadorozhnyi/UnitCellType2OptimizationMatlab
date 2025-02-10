
% Usage:
%  [optOUT]=PSO(functname,D)
% or:
%  [optOUT,tr,te]=...
%        PSO(functname,D,mv,VarRange,minmax,PSOparams,plotfcn,PSOseedValue)
%
% Inputs:
%    functname - string of matlab function to optimize
%    D - # of inputs to the function (dimension of problem)
%    
% Optional Inputs:
%    mv - max particle velocity, either a scalar or a vector of length D
%           (this allows each component to have it's own max velocity), 
%           default = 4, set if not input or input as NaN
%
%    VarRange - matrix of ranges for each input variable, 
%      default -100 to 100, of form:
%       [ min1 max1 
%         min2 max2
%            ...
%         minD maxD ]
%
%    minmax = 0, funct minimized (default)
%                   = 1, funct maximized
%
%    PSOparams - PSO parameters
%      P(1) - Epochs between updating display, default = 100. if 0, 
%             no display
%      P(2) - Maximum number of iterations (epochs) to train, default = 2000.
%      P(3) - population size, default = 24
%
%      P(4) - acceleration const 1 (local best influence), default = 2
%      P(5) - acceleration const 2 (global best influence), default = 2
%      P(6) - Initial inertia weight, default = 0.9
%      P(7) - Final inertia weight, default = 0.4
%      P(8) - Epoch when inertial weight at final value, default = 1500
%      P(9)- minimum global error gradient, 
%                 if abs(Gbest(i+1)-Gbest(i)) < gradient over 
%                 certain length of epochs, terminate run, default = 1e-25
%      P(10)- epochs before error gradient criterion terminates run, 
%                 default = 150, if the SSE does not change over 250 epochs
%                               then exit
%      P(11)- error goal, if NaN then unconstrained min or max, default=NaN
%      P(12)- type flag (which kind of PSO to use)
%                 0 = Common PSO w/intertia (default)
%                 1 = Trelea types 
%                 2   = Clerc's 
%      P(13)- PSOseed, default=0
%               = 0 for initial positions all random
%               = 1 for initial particles as user input
%       P(14) - BoundaryType
%
%    plotfcn - optional name of plotting function, default 'goplotpso',
%              make your own and put here
%
%    PSOseedValue - initial particle position, depends on P(13), must be
%                   set if P(13) is 1 or 2, not used for P(13)=0, needs to
%                   be nXm where n<=ps, and m<=D
%                   If n<ps and/or m<D then remaining values are set random
%                   on Varrange
% Outputs:
%    optOUT - optimal inputs and associated min/max output of function, of form:
%        [ bestin1
%          bestin2
%            ...
%          bestinD
%          bestOUT ]
%
% Optional Outputs:
%    tr    - Gbest at every iteration, traces flight of swarm
%    te    - epochs to train, returned as a vector 1:endepoch
%
% Example:  out=pso_Trelea_vectorized('f6',2)

% Brian Birge
% Rev 3.3
% 2/18/06

function [OUT,varargout]=pso_Trelea_vectorized(functname,D,varargin)

rand('state',sum(100*clock));

if nargin < 2
   error('Not enough arguments.');
end

% ОПРЕДЕЛЕНИЕ ВХОДНЫХ ПЕРЕМЕННЫХ ФУНКЦИИ

if nargin == 2      % only specified functname and D
   VRmin=ones(D,1)*-100; 
   VRmax=ones(D,1)*100;    
   VR=[VRmin,VRmax];
   minmax = 0;
   P = [];
   mv = 4;
   plotfcn='goplotpso2';   
elseif nargin == 3  % specified functname, D, and mv
   VRmin=ones(D,1)*-100; 
   VRmax=ones(D,1)*100;    
   VR=[VRmin,VRmax];
   minmax = 0;
   mv=varargin{1};
   if isnan(mv)
       mv=4;
   end
   P = [];
   plotfcn='goplotpso2';   
elseif nargin == 4  % specified functname, D, mv, Varrange
   mv=varargin{1};
   if isnan(mv)
       mv=4;
   end
   VR=varargin{2}; 
   minmax = 0;
   P = [];
   plotfcn='goplotpso2';   
elseif nargin == 5  % specified functname, D, mv, Varrange, and minmax
   mv=varargin{1};
   if isnan(mv)
       mv=4;
   end    
   VR=varargin{2};
   minmax=varargin{3};
   P = [];
   plotfcn='goplotpso2';
elseif nargin == 6  % specified functname, D, mv, Varrange, minmax, and psoparams
   mv=varargin{1};
   if isnan(mv)
       mv=4;
   end    
   VR=varargin{2};
   minmax=varargin{3};
   P = varargin{4}; % psoparams
   plotfcn='goplotpso2';   
elseif nargin == 7  % specified functname, D, mv, Varrange, minmax, and psoparams, plotfcn
   mv=varargin{1};
   if isnan(mv)
       mv=4;
   end    
   VR=varargin{2};
   minmax=varargin{3};
   P = varargin{4}; % psoparams
   plotfcn = varargin{5}; 
elseif nargin == 8  % specified functname, D, mv, Varrange, minmax, and psoparams, plotfcn, PSOseedValue
   mv=varargin{1};
   if isnan(mv)
       mv=4;
   end    
   VR=varargin{2};
   minmax=varargin{3};
   P = varargin{4}; % psoparams
   plotfcn = varargin{5};  
   PSOseedValue = varargin{6};
else    
   error('Wrong # of input arguments.');
end

%  Параметры PSO по умолчанию
Pdef = [1 200 30 1.7 1.7 0.72 0.6 150 1e-5 100 NaN 1 0 0];
Plen = length(P);
P    = [P,Pdef(Plen+1:end)];

% Параметры PSO 
df      = P(1);
me      = P(2);
ps      = P(3);
ac1     = P(4);
ac2     = P(5);
iw1     = P(6);
iw2     = P(7);
iwe     = P(8);
ergrd   = P(9);
ergrdep = P(10);
errgoal = P(11);
trelea  = P(12);
PSOseed = P(13);
posmaskmeth = P(14);

% error checking
 if ( (PSOseed==1) & ~exist('PSOseedValue') )
     error('PSOseed flag set but no PSOseedValue was input');
 end

 if exist('PSOseedValue')
     tmpsz=size(PSOseedValue);
     if D < tmpsz(2)
         error('PSOseedValue column size must be D or less');
     end
     if ps < tmpsz(1)
         error('PSOseedValue row length must be # of particles or less');
     end
 end
 
% Определение необходимости вывода  статистики PSO в отдельное окно
if (P(1))~=0
  plotflg=1;
else
  plotflg=0;
end

% preallocate variables for speed up
 tr = ones(1,me)*NaN;

% % Определение максимального и минимального значения направления поиска по каждой переменной
if length(mv)==1
 velmaskmin = -mv*ones(ps,D);     % min vel, psXD matrix
 velmaskmax = mv*ones(ps,D);      % max vel
elseif length(mv)==D     
 velmaskmin = repmat(forcerow(-mv),ps,1); % min vel
 velmaskmax = repmat(forcerow( mv),ps,1); % max vel
else
 error('Max vel must be either a scalar or same length as prob dimension D');
end

% Определение максимального и минимального значения каждой переменной
posmaskmin  = repmat(VR(1:D,1)',ps,1);  % min pos, psXD matrix
posmaskmax  = repmat(VR(1:D,2)',ps,1);  % max pos

% Определение типа граничных условий
%   0) no position limiting, 1) absorbing boundary,
%   2) damping boundary ,  3) reflecting boundary
% posmaskmeth = 2;

%  заготовка для вывода статистики в окно Matlab
 message = sprintf('PSO: %%g/%g iterations, GBest = %%20.20g.\n',me);
 
% ИНИЦИАЛИЗАЦИЯ
% initialize population of particles and their velocities at time zero,
% format of pos= (particle#, dimension)
 % construct random population positions bounded by VR
  pos(1:ps,1:D) = normmat(rand([ps,D]),VR',1);
  
  if PSOseed == 1         % initial positions user input, see comments above
    tmpsz                      = size(PSOseedValue);
    pos(1:tmpsz(1),1:tmpsz(2)) = PSOseedValue;  
  end

 % construct initial random velocities between -mv,mv
  vel(1:ps,1:D) = normmat(rand([ps,D]),...
      [forcecol(-mv),forcecol(mv)]',1);

% initial pbest positions vals
 pbest = pos;
 for iii=1:ps
    out(iii,1) = feval(functname,pos(iii,:));  % returns column of cost values (1 for each particle)
 end
 pbestval=out;   % initially, pbest is same as pos

% assign initial gbest here also (gbest and gbestval)
 if minmax==1
   % this picks gbestval when we want to maximize the function
    [gbestval,idx1] = max(pbestval);
 elseif minmax==0
   % this works for straight minimization
    [gbestval,idx1] = min(pbestval);
 end
 gbest          = pbest(idx1,:);  % this is gbest position


% НАЧАЛО ЦИКЛА РАБОТЫ PSO

% start PSO iterative procedures
 cnt    = 0; % counter used for updating display according to df in the options
 cnt2   = 0; % counter used for the stopping subroutine based on error convergence
 out_addon=zeros(ps, 1); % переменная, необходимая для invisible boundary
 
 iwt(1) = iw1;
 
for i=1:me  % start epoch loop (iterations)
    
     if i~=1
        for iii=1:ps
            out(iii,1) = feval(functname,pos(iii,:));  % returns column of cost values (1 for each particle)
        end
     end
     

     % INVISIBLE BOUNDARY
     out=out+out_addon;
     out_addon=zeros(ps, 1);
	 
	 % Сохранение промежуточных результатов расчета
     PARTICLES_OVER_EPOCH(:,:,i)=[pos;gbest];
     VALUES_OVER_EPOCH(:,:,i)=[out;gbestval];

     tr(i+1)          = gbestval; % keep track of global best val
     te               = i; % returns epoch number to calling program when done
     

   % this section does the plots during iterations   
    if plotflg==1      
      if (rem(i,df) == 0 ) | (i==me) | (i==1) 
         fprintf(message,i,gbestval);
         cnt = cnt+1; % count how many times we display (useful for movies)
          
         eval(plotfcn); % defined at top of script
         
      end  % end update display every df if statement    
    end % end plotflg if statement

    
    % find particles where we have new pbest, depending on minmax choice 
    % then find gbest and gbestval
     %[size(out),size(pbestval)]

     if minmax == 0
        [tempi]            = find(pbestval>=out); % new min pbestvals
        pbestval(tempi,1)  = out(tempi);   % update pbestvals
        pbest(tempi,:)     = pos(tempi,:); % update pbest positions
       
        [iterbestval,idx1] = min(pbestval);
        
        if gbestval >= iterbestval
            gbestval = iterbestval;
            gbest    = pbest(idx1,:);
        end
     elseif minmax == 1
        [tempi,dum]        = find(pbestval<=out); % new max pbestvals
        pbestval(tempi,1)  = out(tempi,1); % update pbestvals
        pbest(tempi,:)     = pos(tempi,:); % update pbest positions
 
        [iterbestval,idx1] = max(pbestval);
        if gbestval <= iterbestval
            gbestval = iterbestval;
            gbest    = pbest(idx1,:);
        end
 
     end

 
     %PSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSOPSO

      % get new velocities, positions (this is the heart of the PSO algorithm)     
      % each epoch get new set of random numbers
       rannum1 = rand([ps,D]); % for Trelea and Clerc types
       rannum2 = rand([ps,D]);       
       if     trelea == 2    
        % from Clerc's paper, parameter set 2
         vel = 0.729.*vel...                              % prev vel
               +1.494.*rannum1.*(pbest-pos)...            % independent
               +1.494.*rannum2.*(repmat(gbest,ps,1)-pos); % social  
       elseif trelea == 1
        % from Trelea's paper, parameter set 1                     
         vel = 0.600.*vel...                              % prev vel
               +1.700.*rannum1.*(pbest-pos)...            % independent
               +1.700.*rannum2.*(repmat(gbest,ps,1)-pos); % social 
       else
        % common PSO algorithm with inertia wt 
        % get inertia weight, just a linear funct w.r.t. epoch parameter iwe
         if i<=iwe
            iwt(i) = ((iw2-iw1)/(iwe-1))*(i-1)+iw1;
         else
            iwt(i) = iw2;
         end
        % random number including acceleration constants
         ac11 = rannum1.*ac1;    % for common PSO w/inertia
         ac22 = rannum2.*ac2;
         
         vel = iwt(i).*vel...                             % prev vel
               +ac11.*(pbest-pos)...                      % independent
               +ac22.*(repmat(gbest,ps,1)-pos);           % social                  
       end
       
       % limit velocities here using masking
        vel = ( (vel <= velmaskmin).*velmaskmin ) + ( (vel > velmaskmin).*vel );
        vel = ( (vel >= velmaskmax).*velmaskmax ) + ( (vel < velmaskmax).*vel );     
        
       % update new position (PSO algo)    
        pos = pos + vel;
    
       % position masking, limits positions to desired search space
       % method: 0) no position limiting, 1) absorbing boundary,

       %         2) damping boundary , 3) reflecting boundary
        minposmask_throwaway = pos <= posmaskmin;  % these are psXD matrices
        minposmask_keep      = pos >  posmaskmin;     
        maxposmask_throwaway = pos >= posmaskmax;
        maxposmask_keep      = pos <  posmaskmax;
     
        if     posmaskmeth == 1
         % ABSORBING BOUNDARY
         % частица останавливается на границе, а направление вектора скорости 
         % приравнивается 0 по тем координатам, по которым 
         % превышена граница
          pos = ( minposmask_throwaway.*posmaskmin ) + ( minposmask_keep.*pos );
          pos = ( maxposmask_throwaway.*posmaskmax ) + ( maxposmask_keep.*pos );
          
          vel = (vel.*minposmask_keep) + (0.*minposmask_throwaway);
          vel = (vel.*maxposmask_keep) + (0.*maxposmask_throwaway);
          
        elseif posmaskmeth == 2

         % DAMPING BOUNDARY
         % частица останавливается на границе, а направление вектора скорости 
         % меняется на противоположное по тем координатам, по которым 
         % превышена граница, с элементом случайности.  
          pos = ( minposmask_throwaway.*posmaskmax ) + ( minposmask_keep.*pos );
          pos = ( maxposmask_throwaway.*posmaskmin ) + ( maxposmask_keep.*pos ); 
          
          
          vel = (vel.*minposmask_keep) + (-vel.*rand(ps, D).*minposmask_throwaway);
          vel = (vel.*maxposmask_keep) + (-vel.*rand(ps, D).*maxposmask_throwaway);
          
        elseif posmaskmeth == 3

         % REFLECTING BOUNDARY
         % частица останавливается на границе, а направление вектора скорости 
         % меняется на противоположное по тем координатам, по которым 
         % превышена граница      
          pos = ( minposmask_throwaway.*posmaskmin ) + ( minposmask_keep.*pos );
          pos = ( maxposmask_throwaway.*posmaskmax ) + ( maxposmask_keep.*pos );

          vel = (vel.*minposmask_keep) + (-vel.*minposmask_throwaway);
          vel = (vel.*maxposmask_keep) + (-vel.*maxposmask_throwaway);
          
          
        elseif   posmaskmeth == 4
            % INVISIBLE BOUNDARY
            % частица может находиться где угодно, но значение ЦФ 
            % получает дополнение в 500, что гарантирует, что при
            % минимизации не изменятся значения pbest  и gbest
            
            % minposmask_throwaway - psXD; boundary_analysis - psX1
            boundary_analysis=sum(minposmask_throwaway, 2)+sum(maxposmask_throwaway, 2);
            
            out_addon=(boundary_analysis>0)*500;
            
            boundary_analysis=zeros(ps, 1);

        else
         % no change, this is the original Eberhart, Kennedy method, 
         % it lets the particles grow beyond bounds if psoparams (P)
         % especially Vmax, aren't set correctly, see the literature
        end


        % Should the PSO be stopped?
        
    % check for stopping criterion based on speed of convergence to desired 
    % error   
    tmp1 = abs(tr(i) - gbestval);
    if tmp1 > ergrd
       cnt2 = 0;
    elseif tmp1 <= ergrd
       cnt2 = cnt2+1;
       if cnt2 >= ergrdep
         if plotflg == 1
          fprintf(message,i,gbestval);           
          disp(' ');
          disp(['--> Solution likely, GBest hasn''t changed by at least ',...
              num2str(ergrd),' for ',...
                  num2str(cnt2),' epochs.']);  
          eval(plotfcn);
         end       
         break
       end
    end
    
   % this stops if using constrained optimization and goal is reached
    if ~isnan(errgoal)
     if ((gbestval<=errgoal) & (minmax==0)) | ((gbestval>=errgoal) & (minmax==1))  

         if plotflg == 1
             fprintf(message,i,gbestval);
             disp(' ');            
             disp(['--> Error Goal reached, successful termination!']);
             
             eval(plotfcn);
         end
         break
     end
 
    end  % end ~isnan if

end  % end epoch loop


% output & return
 OUT=[gbest';gbestval];
 varargout{1}=[1:te];
 varargout{2}=[tr(find(~isnan(tr)))];
 
 save(['PSO_particles.mat'], 'PARTICLES_OVER_EPOCH', 'VALUES_OVER_EPOCH');
 
 return