classdef optimization
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        fmin;
        fmax;
        f0;
        phase_span_D;
        ampl_delta_D;
        ampl_ave_D;
        a1;
        a2;
        cost_thr;
        V;
        N_V;

        real;
        imag;
        z;
        amplitude;
        phase_rad;
        phase_rad_u;
        phase_deg;
        phase_deg_u;
        freq;
        phase_span;
        amplitude_f0;
        phase_deg_f0;
        ampl_delta;
        ampl_ave;

        cost;
        cost0;
        cost1;
        cost2;
    end

    methods
        function opt = processSparam(opt, path_result)
            for v_idx=1:opt.N_V

                
                
                path = sprintf("%s\\DS_for_MWS-run-%04d.s1p", path_result, v_idx);
                sparam = sparameters(path);
                sparam = newref(sparam,376.73532);

                opt.freq = (sparam.Frequencies/1e9)'; % GHz

                for f_idx=1:length(opt.freq)
                    opt.z(f_idx,v_idx) = sparam.Parameters(:,:,f_idx);
                end
            
                opt.amplitude(:,v_idx) = abs(opt.z(:,v_idx));
                opt.phase_rad(:,v_idx) = angle(opt.z(:,v_idx));
                opt.phase_rad_u(:,v_idx) = unwrap(opt.phase_rad(:,v_idx));
            
                opt.phase_deg(:,v_idx) = opt.phase_rad(:,v_idx)*180/pi;
                opt.phase_deg_u(:,v_idx) = opt.phase_rad_u(:,v_idx)*180/pi;
                
                % Check the Unwrapped Phase
                f1_idx = 0;
                f2_idx = 0;
                phase1 = nan(length(opt.freq),1);
                phase2 = nan(length(opt.freq),1);
                for f_idx=3:length(opt.freq)
                    A = opt.phase_deg_u(f_idx-2,v_idx);
                    B = opt.phase_deg_u(f_idx-1,v_idx);
                    C = opt.phase_deg_u(f_idx,v_idx);
                    
                    if (B-A<0) && (C-B<0)
                        phase1(f_idx-2,1) = A;
                        phase1(f_idx-1,1) = B;
                        phase1(f_idx,1)   = C;
                    elseif (B-A<0) && (C-B>0)
                        phase1(f_idx-2,1) = A;
                        phase1(f_idx-1,1) = B;
                        f1_idx = f_idx-1;
                        phase2(f_idx-1,1) = B;
                        phase2(f_idx,1)   = C;
                    elseif (B-A>0) && (C-B>0)
                        phase2(f_idx-2,1) = A;
                        phase2(f_idx-1,1) = B;
                        phase2(f_idx,1)   = C;
                    elseif (B-A>0) && (C-B<0)
                        phase2(f_idx-2,1) = A;
                        phase2(f_idx-1,1) = B;
                        f2_idx = f_idx-1;
                        phase1(f_idx-1,1) = B;
                        phase1(f_idx,1)   = C;
                    end
                end
                if(f2_idx ~= 0)
                    phase1(f2_idx:end) = phase1(f2_idx:end)-360;
                    phase2 = -1*phase2;
                    d = (phase1(f1_idx) - phase1(f2_idx)) / (phase2(f1_idx) - phase2(f2_idx));
                    
                    phase2 = d*phase2;
                    s = phase1(f1_idx) - phase2(f1_idx);
                    phase2  = phase2 + s;

                    
                    % figure(2)
                    % hold on
                    % plot(opt.freq, phase1)
                    % plot(opt.freq, phase2)
                    % plot(opt.freq, opt.phase_deg_u(:,i))
                    % hold off
                    % grid on

                    for f_idx=1:length(opt.freq)
                        if isnan(phase2(f_idx,1))
                            opt.phase_deg_u(f_idx,v_idx) = phase1(f_idx,1);
                        else
                            opt.phase_deg_u(f_idx,v_idx) = phase2(f_idx,1);
                        end
                    end
                end

                

            end
            %opt.freq = sparam(:,1);
        end

        function opt = calculateCost(opt)

            opt.phase_span = (opt.phase_deg_u(:,end) - opt.phase_deg_u(:,1))';

            N_freq = length(opt.freq);
            N_delta = 0;
            opt.cost0 = 0;
            opt.cost1 = 0;
            opt.cost2 = 0;
            for i=1:N_freq
                if opt.freq(1,i)>=opt.fmin && opt.freq(1,i)<=opt.fmax
                    delta = opt.phase_span(1,i) - opt.phase_span_D; 
                    if delta<0
                        N_delta = N_delta+1;
                        opt.cost0 = opt.cost0 + delta*delta;
                    end
                end
            
                if opt.freq(1,i) == opt.f0
                    for j=1:opt.N_V
                        opt.amplitude_f0(1,j) = opt.amplitude(i,j);
                        opt.phase_deg_f0(1,j) = opt.phase_deg_u(i,j);
                    end
                    opt.phase_deg_f0 = opt.phase_deg_f0 - opt.phase_deg_f0(1,1);
                    opt.ampl_delta = max(opt.amplitude_f0) - min(opt.amplitude_f0);
                    opt.ampl_ave = sum(opt.amplitude_f0) / opt.N_V;
                end
            end
            if opt.cost0 ~= 0
                opt.cost0 = (opt.cost0/N_delta);
            end

            diff1 = (opt.ampl_delta - opt.ampl_delta_D)*1000;
            if(abs(diff1) > 100)
                opt.cost1 = opt.a1*((diff1)^2);
            end

            diff2 = (opt.ampl_ave_D - opt.ampl_ave)*1000;
            if(abs(diff2) > 100)
                opt.cost2 = opt.a2*(diff2^2);
            end
            opt.cost = opt.cost0 + opt.cost1 + opt.cost2;
        end
    end
end