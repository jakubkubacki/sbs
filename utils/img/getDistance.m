function distance = getDistance(p1, p2)
    distance = sqrt(sum((p2 - p1) .* (p2 - p1)));
end

