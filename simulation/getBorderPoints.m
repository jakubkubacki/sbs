function borderPoints = getBorderPoints(img, d)
    borderPoints = [];
    imgSize = size(img);
    steps = floor(imgSize ./ d);
    for i = 1:steps(1) % i -> Y
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
    for i = 1:steps(2) % i -> X
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
