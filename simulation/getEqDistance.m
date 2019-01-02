function eqDistance = getEqDistance(simulationState)
    innerPointsLen = simulationState.consts.innerPointsLen;
    neighbours = simulationState.neighbours;
    
    eqDistance = 0;
    pointsLen = 0;
    for i = 1:innerPointsLen
        p1 = simulationState.points(i, :);
        localN = neighbours{i};
        
        for j = 1:length(localN)
            p2 = simulationState.points(localN(j), :);
            eqDistance = eqDistance + getDistance(p1, p2);
            
            pointsLen = pointsLen + 1;
        end
    end
    
    eqDistance = eqDistance / pointsLen;
end

