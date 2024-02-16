function dist = chiSquaredDist(hist1, hist2)
% Calculate the Chi-squared distance between two histograms
% hist1 and hist2 must be vectors of non-negative integers

numBins = length(hist1);

dist = 0;

for i = 1:numBins
    obs1 = hist1(i);
    obs2 = hist2(i);
    exp = (hist1 + hist2) / 2;
    dist = dist + (obs1 - exp)^2 / exp;
end

dist = dist / numBins;