function neighbours = getNeighbours(zones, points, sbZnSize)
    pointsLen = length(points);
    neighbours = cell(1, pointsLen);
    
    for i = 1:pointsLen
        point = points(i, :);
        pointZoneIndex = fliplr(ceil(point ./ sbZnSize));
        subZone = getSubZone(zones, pointZoneIndex);
        distances = getDistances(subZone, points, point);
        
        r = length(distances);
        r = min(r, 7);
        localNeighbours = distances(2:r, 1)';
        neighbours{i} = localNeighbours; 
        
    end
    
    % Nested functions
    
    function zone = getSubZone(zones, pointZoneIndex)
        zonesSize = size(zones);
        
        x0 = max([1, pointZoneIndex(2) - 1]);
        x1 = min([pointZoneIndex(2) + 1, zonesSize(2)]);
        y0 = max([1, pointZoneIndex(1) - 1]);
        y1 = min([pointZoneIndex(1) + 1, zonesSize(1)]);
        
        zone = [];
        for x = x0:x1
            for y = y0:y1
                zone = [zone, zones{y,x}];
            end
        end
    end
    
    function distances = getDistances(subZone, points, point)
        distances = [subZone', zeros(length(subZone), 1)];
        
        for k = 1:length(subZone)
            p2 = points(subZone(k), :);
            d2 = sum((point - p2) .* (point - p2)); 
            distances(k, 2) = sqrt(d2);
        end
        
        distances = sortrows(distances, 2);
    end
end