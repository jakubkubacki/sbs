function simulationState = initialize(filePath, filePath2, ...
        innerPointsLen, step)
    
    % 0. Setup state
    simulationState = {};
    simulationState.consts = {};
    simulationState.consts.innerPointsLen = innerPointsLen;
    simulationState.consts.path = filePath;
    simulationState.consts.path2 = filePath2;
    simulationState.consts.step = step;
    
    % Initialization based on image1
    simulationState = initializeWithImage(simulationState, filePath, ...
        innerPointsLen);
    
    % 7. Get eq distance
    eqDistance = getEqDistance(simulationState);
    simulationState.consts.eqDistance = eqDistance;
    
    % Initialization based on image2
    [simulationState, innerPoints, borderPoints, neighbours] ...
        = initializeWithImage(simulationState, filePath2, innerPointsLen);
    
    % 9. Get energy value
    energies = getEnergies(innerPoints, borderPoints, neighbours, ...
        eqDistance);
    simulationState.energies = energies;
    
    function [simulationState, innerPoints, borderPoints, neighbours] ...
            = initializeWithImage(simulationState, ...
                filePath, innerPointsLen)
        % 1. Load image
        img = loadImage(filePath);
        simulationState.img = img;
        imgSize = size(img);
        
        % 2. Get border points
        borderPoints = getBorderPoints(img, 20);
        
        % 3. Set up zones
        area = sum(sum(img));
        sbZnSize = sqrt(6 * area / ...
            (innerPointsLen + length(borderPoints)));
        simulationState.consts.sbZnSize = sbZnSize;
        simulationState.zones = cell(ceil(imgSize ./ sbZnSize));
        
        % 4. Get inner points
        innerPoints = getInnerPoints(innerPointsLen, img);
        simulationState.points = [innerPoints; borderPoints];
        
        % 5. Divide points into zones
        simulationState.zones = setPointsZones(simulationState.zones, ...
            simulationState.points, ...
            sbZnSize);
        
        % 6. Get neighbours
        neighbours = getNeighbours(simulationState.zones, ...
            simulationState.points, ...
            sbZnSize);
        simulationState.neighbours = neighbours;
    end
    
end