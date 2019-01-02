function energies = getEnergies(innerPoints, borderPoints, neighbours, eqDistance)
    innerPointsLen = length(innerPoints);
    allPoints = [
        innerPoints; 
        borderPoints
    ];
    
    energies = cell(1, innerPointsLen);
    
    for pointIndex = 1:innerPointsLen
        p1 = allPoints(pointIndex, :);
        localN = neighbours{pointIndex};
        localNlen = size(localN);
        localNlen = localNlen(2);
        
        for k = 1:localNlen
            p2 = allPoints(localN(1, k), :);
            
            distance = eqDistance - sqrt(sum((p2 - p1) .* (p2 - p1)));
            energy = distance * distance;
            
            energies{pointIndex} = [energies{pointIndex}, energy];
            
            if localN(1, k) <= length(energies)
                energies{localN(1, k)} = [energies{localN(1, k)}, energy];
            end
        end
    end
end

