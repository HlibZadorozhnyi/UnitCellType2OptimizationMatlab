function runID = getRunID(Wline, Wgap)
    runID = sprintf('%04d', round(Wline*100));
    for i=1:length(Wgap)
        runID = sprintf('%s%04d', runID, round(Wgap(i)*100));
    end
end