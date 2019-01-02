function [result] = isInImage(img, point)
    result = false;
    flooredPoint = floor(point);
    imgSize = size(img);
    if isIndex(flooredPoint(1), flooredPoint(2), imgSize)
        result = img(flooredPoint(2), flooredPoint(1));
    end
end

