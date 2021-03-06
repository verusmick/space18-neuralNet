function [Y,Xf,Af] = ANN(X,~,~)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 20-Oct-2018 03:37:23.
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = Qx3 matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = Qx3 matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-0.492165336631769;-0.528844627125243;-0.625854786730399];
x1_step1.gain = [2;2;2];
x1_step1.ymin = -1;

% Layer 1
b1 = [-2.4857831661242247;-4.8397052071465536;0.13672598396827501;-1.364263137452618;1.3569617163702452;-0.082267344153612795;-1.7695579049279353;2.2438460980277903;4.7231019994633154;3.0211379077828422];
IW1_1 = [-0.44140754537265625 4.2187476347821642 -2.6844068644527983;-0.082438604334784282 0.42789459855324818 4.0924283433305693;-3.7865332418946567 -2.4548715744854337 3.5422754258078109;3.5575626557015361 4.3009847359722464 3.4656521556018514;2.0741320982450553 -3.850872478113661 2.7462904213729802;3.9418291848202185 -0.95683354162079937 3.3244497574129928;-4.5909268518164748 -0.98516150673317615 0.34181801046391114;-0.57650319536411865 3.1684274203275105 1.0274873925955867;4.8747277909572135 -4.5257395605723181 0.086027555328051175;1.3836883657802774 4.1666667224797598 2.4129876684346643];

% Layer 2
b2 = [0.69339877953471096;-0.074264699073256238;-0.43864901953153518];
LW2_1 = [1.303603118480801 -5.5068451269005214 0.38647550357605009 -1.0410240344278128 -1.9440777679482131 4.8504270447064233 3.0190246087542132 -1.0542817210284159 0.9148575284815138 -2.6067847203169729;-0.051330792645257119 0.11860325352311855 -0.0033277035822264723 0.0042711222514577206 0.0055162125220941651 -0.078771368399888478 -0.071395036853558816 -0.028427976851101263 -0.010013975326961685 0.088423292869703712;0.011834206964949733 -0.009498696644814078 0.0024403071587031358 -0.00038661332731096095 -7.0452229319168901e-05 0.0096029598686207633 0.0061175564426381454 0.0091469317796532088 -0.0015539024406089979 -0.01806171635575908];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [2;2;2];
y1_step1.xoffset = [-0.492831737008146;-0.467721257663235;-0.275963978444913];

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX
    X = {X};
end

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
    Q = size(X{1},1); % samples/series
else
    Q = 0;
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    X{1,ts} = X{1,ts}';
    Xp1 = mapminmax_apply(X{1,ts},x1_step1);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1);
    Y{1,ts} = Y{1,ts}';
end

% Final Delay States
Xf = cell(1,0);
Af = cell(2,0);

% Format Output Arguments
if ~isCellX
    Y = cell2mat(Y);
end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
