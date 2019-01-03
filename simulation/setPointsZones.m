function zones = setPointsZones(inputZones, points, sbZnSize)
    zones = cell(size(inputZones));
    
    for i = 1:length(points)
        point = fliplr(ceil(points(i, :) ./ sbZnSize));
        zones{point(1), point(2)} = [zones{point(1), point(2)}, i];
    end 
end