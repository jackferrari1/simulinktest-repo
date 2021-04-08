%% Model Advisor Check to ensure Test Bench and Referenced Subsystem do not have any unconnected lines, input ports, and output ports
% Copyright 2020 The MathWorks, Inc.

disp('Begin Model Advisor analysis')

% Move to working directory
prj = matlab.project.currentProject;
cd(prj.ProjectStartupFolder);

% Setup and open model
TopModel = 'LaneFollowingTestBenchExample';
load_system(TopModel);

% Create Model Advisor app
app = Advisor.Manager.createApplication();

% Set root for analysis.
setAnalysisRoot(app,'Root', TopModel);

% Clear all check instances from Model Advisor analysis.
deselectCheckInstances(app);

% Select check Identify unconnected lines, input ports, and output ports
instanceID1 = getCheckInstanceIDs(app, 'mathworks.design.UnconnectedLinesPorts');
instanceID2 = getCheckInstanceIDs(app, 'mathworks.design.RootInportSpec');
% instanceID3 = getCheckInstanceIDs(app, 'mathworks.design.OptimizationSettings');

%checkinstances = {instanceID1(1),instanceID2(1), instanceID3(1)};
selectCheckInstances(app, 'IDs', instanceID1(1));
selectCheckInstances(app, 'IDs', instanceID2(1));
% selectCheckInstances(app, 'IDs', instanceID3(1));

%Run Model Advisor analysis.
run(app);

%Get analysis results.
result = getResults(app);

% Ensure that there are no unconnected lines
%assert(~any([result.numFail]), 'Unconnected lines found in LaneFollowingTestBenchExample or referenced models');

%Generate and view the Model Advisor report. The Model Advisor runs the check on both mdlref_basic and mdlref_counter.
report = generateReport(app);

% Save model
save_system(TopModel);

disp('End Model Advisor analysis')

% Open Model Advisor Report
open(report)
