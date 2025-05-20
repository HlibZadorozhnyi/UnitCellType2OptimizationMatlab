function path_result_USER = runCST(N_results, Wgap, Wline)


    
    %------------------------------------------------------------------------%
    
    listing = dir();
    function_evaluation = N_results+1;
    path_result_USER = sprintf('%s\\Results\\Function_Evaluation_%06d', listing(1).folder, function_evaluation);
    mkdir(path_result_USER);
    
    path_CST = 'C:\Program Files (x86)\CST Studio Suite 2024\AMD64\CST DESIGN ENVIRONMENT_AMD64.exe';
    path_bas = sprintf('%s\\file.bas', listing(1).folder);
    % path_result_CST  = sprintf('%s\\CST\\unitcell\\Result\\DS\\TOUCHSTONE files', path_result_USER);
    path_project = sprintf('%s\\CST\\unitcell.cst', listing(1).folder);
    
    cmd = sprintf("copy %s  %s", path_project, path_result_USER);
    % disp(cmd);
    [status,cmdout] = system(cmd);
    
    % if isfolder(path_result_CST)
    %     rmdir(path_result_CST, 's')
    % end
    
    fileID = fopen('file.bas','w');
    fprintf(fileID,'Option Explicit\n');
    fprintf(fileID,'Sub Main ()\n');
    fprintf(fileID,'OpenFile ("%s\\unitcell.cst")\n', path_result_USER);
    %fprintf(fileID,'DeleteResults\n');
    
    fprintf(fileID,'StoreDoubleParameter ("Wline", %.3f)\n', Wline);
    for i=1:length(Wgap)
        fprintf(fileID,'StoreDoubleParameter ("Wgap%d", %.3f)\n',i, Wgap(i));
    end
    fprintf(fileID,'Rebuild\n');
    fprintf(fileID,'SimulationTask.Name("SPara1")\n');
    fprintf(fileID,'SimulationTask.Update\n');
    
    fprintf(fileID,'End Sub\n');
    fclose(fileID);
    
    cmd = sprintf("%s%s%s -m %s", '"', path_CST, '"', path_bas);
    %disp(cmd);
    [status,cmdout] = system(cmd);
    
    %copyfile(path_result_CST, path_result_USER)



end