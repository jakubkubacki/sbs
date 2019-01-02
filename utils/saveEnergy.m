function simState = saveEnergy(simState)
    savedLen = size(simState.savedEnergies);
    savedLen = savedLen(1);
    
    energy = 0;
    for i = 1:length(simState.energies)
        energy = energy + sum(simState.energies{i});
    end
    simState.savedEnergies = [
        simState.savedEnergies; 
        now, energy];
    
    simState.savedPositions{savedLen + 1, 1} = now;
    simState.savedPositions{savedLen + 1, 2} = simState.points;
    
end