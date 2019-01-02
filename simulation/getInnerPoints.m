function innerPoints = getInnerPoints(nPoints, img)
    imgSize = size(img);
    
    innerPoints = zeros(nPoints, 2);
    i = 1;
    while i <= nPoints
        point = floor(rand(1, 2) .* (imgSize - 1)) + 1;
        
        if img(point(1), point(2))
            innerPoints(i, :) = fliplr(point);
            i = i + 1;
        end
    end
    
end
