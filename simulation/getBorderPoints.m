function borderPoints = getBorderPoints(img, d)
    
    borderPoints = [];
    imgSize = size(img);
    
    steps = floor(imgSize ./ d);
    % i -> Y
    for i = 1:steps(1)
        row = img(i * d, :);
        for k = 2:length(row)
            if xor(row(k), row(k - 1))
                borderPoints = [
                    borderPoints;
                    k, i * d
                    ];
            end
        end
    end
    
    % i -> X
    for i = 1:steps(2)
        col = img(:, i * d);
        for k = 2:length(col)
            if xor(col(k), col(k - 1))
                borderPoints = [
                    borderPoints;
                    i * d, k
                    ];
            end
        end
    end    
end
