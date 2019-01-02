function [simulationState] = modifyPoint(simulationState, pointIndex)
    point = simulationState.points(pointIndex, :);
    neighbours = simulationState.neighbours{pointIndex};
    oldEnergy = simulationState.energies{pointIndex};
    step = simulationState.consts.step;
    eqDistance = simulationState.consts.eqDistance;
    
    movedPoint = changePosition(point, step);
    if isInImage(simulationState.img, movedPoint)
        newEnergy = oldEnergy;
        
        for i = 1:length(neighbours)
            nIndex = neighbours(1, i);
            p2 = simulationState.points(nIndex);
            
            distance = eqDistance - sqrt(sum((p2 - movedPoint) .* (p2 - movedPoint)));
            energy = distance * distance;
            
            newEnergy(i) = energy;
        end
        
        newSum = sum(newEnergy);
        oldSum = sum(oldEnergy);
        
        if newSum < oldSum
            simulationState = setChange(simulationState, newEnergy, pointIndex, movedPoint);
            simulationState = updateZone(point, movedPoint, pointIndex, simulationState);
        else
            W = exp(-abs(oldSum - newSum));
            if W > rand
                simulationState = setChange(simulationState, newEnergy, pointIndex, movedPoint);
            end
        end
    end
    function state = setChange(state, newE, index, mPoint)
        state.energies{index} = newE;
        state.points(index, :) = mPoint;
    end
    
    function movedPoint = changePosition(selectedPoint, step)
        movedPoint = selectedPoint + floor(3 * rand(1, 2) - 1) ...
            .* step .* [1, 1];
    end
    
    function simulationState = updateZone(prevPosition, nextPosition, pointIndex, simulationState)
        prevIndex = fliplr(ceil(prevPosition ./ simulationState.consts.sbZnSize));
        nextIndex = fliplr(ceil(nextPosition ./ simulationState.consts.sbZnSize));
        
        if prevIndex ~= nextIndex
            try
                prevZone = simulationState.zones{prevIndex(1), prevIndex(2)};
                prevZone = prevZone(prevZone ~= pointIndex);
                simulationState.zones{prevIndex(1), prevIndex(2)} = prevZone;
                
                nextZone = simulationState.zones{nextIndex(1), nextIndex(2)};
                nextZone = [nextZone, pointIndex];
                simulationState.zones{nextIndex(1), nextIndex(2)} = nextZone;
            catch e
                disp(e);
            end
        end
    end
end

