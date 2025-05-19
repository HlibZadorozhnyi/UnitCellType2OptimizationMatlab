function cost = singleRun(x)
    optim = optimization;

    optim.fmin = 10.7;
    optim.fmax = 11.3;
    optim.f0 = 11;
    optim.phase_span_D = 240;
    optim.ampl_ave_D = 0.7;
    optim.ampl_delta_D = 0.3;
    % optim.ampl_delta_D = (1-optim.ampl_ave_D)*2;
    optim.a1 = 0.1;
    optim.a2 = 0.1;
    optim.cost_thr = 0.01;
    optim.V=0:2:20;
    optim.N_V = length(optim.V);

    x = round(x, 3);

    Wline = x(1,1);
    Wgap1 = x(1,2);
    Wgap2 = x(1,3);
    Wgap3 = x(1,4);
    Wgap4 = x(1,5);
    Wgap5 = x(1,6);
    Wgap6 = x(1,7);
    Wgap7 = 0.35;
    Wgap = [Wgap1 Wgap2 Wgap3 Wgap4 Wgap5 Wgap6];

    if (Wline >= 0.95) && ((Wline+2*Wgap7) <= 9) ...
            && (Wgap1 >= 0.1)  && (Wgap2 >= 0.1)  && (Wgap3 >= 0.1)  && (Wgap4 >= 0.1) ...
            && (Wgap5 >= 0.1)  && (Wgap6 >= 0.1)

        

        listing = dir();
        path_results = sprintf('%s\\Results\\', listing(1).folder);
        listing_results = dir(path_results);
        N_results = length(listing_results)-2;
        
        runID = getRunID(Wline, Wgap);
        path_result = "";
        
        if N_results == 0
            
            path_result = runCST(N_results, Wgap, Wline);
            
            runIDfilePath = sprintf('%s\\runID.txt', path_result);
            runIDfile = fopen(runIDfilePath, "w+");
            fprintf(runIDfile, "%s", runID);
            fclose(runIDfile);

        elseif N_results > 0

            
            for i=1:N_results
                runID_resultPath = sprintf('%s\\Function_Evaluation_%06d\\runID.txt', path_results, i);
                runID_result = readlines(runID_resultPath);
                if runID_result == runID 
                    path_result = sprintf('%s\\Function_Evaluation_%06d', path_results, i);
                end
            end

            if path_result == ""
                path_result = runCST(N_results, Wgap, Wline);
                runIDfilePath = sprintf('%s\\runID.txt', path_result);
                runIDfile = fopen(runIDfilePath, "w+");
                fprintf(runIDfile, "%s", runID);
                fclose(runIDfile);
            end
        end
        optim = optim.processSparam(path_result);
        optim = optim.calculateCost();
        cost = optim.cost;
    else
        cost = 100000;
    end
    

    


    % figure('Name',sprintf('Wgap=%.3f_Wline=%.3f_L=%.3f', Wgap, Wline, L));
    %     subplot(3,2,1)
    %     plot(optim.freq, optim.phase_deg_u)
    %     title('Phase-to-frequency versus voltage')
    %     ylabel('Phase [deg]')
    %     xlabel('Frequency [GHz]')
    %     grid on
    % 
    %     subplot(3,2,3)
    %     plot(optim.freq, optim.amplitude)
    %     ylim([0 1])
    %     title('Amplitude-to-frequency versus voltage')
    %     ylabel('Amplitude [1]')
    %     xlabel('Frequency [GHz]')
    %     grid on
    % 
    %     subplot(3,2,5)
    %     hold on
    %     plot(optim.freq, optim.phase_span)
    %     yline(optim.phase_span_D, '--r', {sprintf('Desired = %.2f', optim.phase_span_D)})
    %     xline(optim.fmin, '--b', {sprintf('fmin = %.2f', optim.fmin)})
    %     xline(optim.fmax, '--b', {sprintf('fmax = %.2f', optim.fmax)})
    %     xline(optim.f0, '--b', {sprintf('f0 = %.2f', optim.f0)})
    %     hold off
    %     ylim([0 360])
    %     title('Phase span')
    %     ylabel('Phase [deg]')
    %     xlabel('Frequency [GHz]')
    %     grid on
    % 
    %     subplot(3,2,2)
    %     plot(optim.V, optim.phase_deg_f0)
    %     ylim([0 360])
    %     title('Phase-to-voltage at the f0')
    %     ylabel('Phase [deg]')
    %     xlabel('Voltage [V]')
    %     grid on
    % 
    %     subplot(3,2,4)
    %     hold on
    %     plot(optim.V, optim.amplitude_f0)
    %     yline(optim.ampl_ave, '--r', {sprintf('Average = %.2f, MaxToMin = %.2f', optim.ampl_ave, optim.ampl_delta)})
    %     hold off
    %     ylim([0 1])
    %     title('Amplitude-to-voltage at the f0')
    %     ylabel('Amplitude [1]')
    %     xlabel('Voltage [V]')
    %     grid on

        
end