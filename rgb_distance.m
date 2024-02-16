function distance = rgb_distance(histogram1, histogram2)
  % Calculate the Euclidean distance between the two histograms
  distance = sqrt(sum((histogram1 - histogram2).^2));
end