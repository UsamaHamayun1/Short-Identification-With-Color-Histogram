function distance = bhattacharyyaDistance(hist1, hist2)
    % Calculate Bhattacharyya distance
    distance = sum(sqrt(hist1 .* hist2));
end