dirName = 'C:\Users\mohamed\OneDrive - Cleveland State University\Lab\UroMonitor\Volume Sensing\Conductance Data';

dirResult = dir(dirName);

allDirs = dirResult([dirResult.isdir]);

allSubDirs = allDirs(3:69);

for i = 1:length(allSubDirs)
    thisDir = allSubDirs(i);
    thisDirName = thisDir.name;
    oldname = fullfile(dirName, thisDirName);
    newname = fullfile(dirName, [thisDirName(end-3:end), '-', thisDirName(1:5)]);
    movefile(oldname, newname);
end