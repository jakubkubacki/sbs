function [is] = isIndex(x, y, imgSize)
    is = (x >= 1 && y >= 1 && x <= imgSize(2) && y <= imgSize(1));
end

