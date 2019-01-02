function img = loadImage(filePath)
    img = ~imread(filePath);
    
    imgSize = size(img);
    if length(imgSize) >= 3
        img = rgb2gray(double(img));
    end
    
    img = flipud(img);
end

