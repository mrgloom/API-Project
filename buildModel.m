function [model, mu, range] = buildModel(dirName)
%BUILDMODEL Builds a RBM
%   Detailed explanation goes here

files = getAllFiles(dirName);
X = zeros(numel(files), 1000);

counter = 0;
for i = 1:numel(files)
    filename = char(files(i));
    rev = fliplr(filename);
    label = rev(12);
    if strcmp(label, 'O')
        continue;
    end
        
    fileName = char(files(i));
    f = preprocess(fileName);
    
    counter = counter + 1;
    X(counter,:) = f;
end

X = X(1:counter,:);

%% Feature scaling

mu = mean(X);
range = max(X) - min(X);

% Scale features
X = (X - repmat(mu, counter, 1)) ./ repmat(range, counter, 1);
% To [0,1] scale
X = (X + 1) / 2;

%% RBM
model = rbmBB(X, 100, 'maxepoch', 10, 'verbose', true);

end

