function simulationState = runSimulation(innerPointsLen, step, maxLoop, filePath, filePath2)
    % Funkcja uruchamiajaca symulacje. 
    % innerPointsLen - ilosc punktow wewnetrznych,
    % step - dlugosc przesuniecia,
    % maxLoop - ilosc punktow do zapisu (dane zapisywane co 100 krokow
    %           symulacji),
    % filePath - sciezka do obrazu kosci nieobciazonej,
    % filePath2 - sciezka do obrazu kosci obciazonej.
    
    addpath('./simulation', './utils', './utils/img')

    saveFreq = 100;
    
    simulationState = initialize(filePath, filePath2, innerPointsLen, step);
    simulationState.savedEnergies = [];
    simulationState.savedPositions = {};
    
    loopCounter = 0;
    while loopCounter <= (maxLoop * saveFreq)
        for i = 1:innerPointsLen
            [simulationState] = modifyPoint(simulationState, i);
            if mod(loopCounter, saveFreq) == 0
                simulationState = saveEnergy(simulationState);
            end
            loopCounter = loopCounter + 1;
        end
    end
    
end

