%% Yash Patel, 201301134 %%

% Find the imperfect bottle. %

% Read the image. %
im = imread('bottles.tif');

% Convert this image to binary image. %
im_bw = im2bw(im, 0.8);
im_bw_bottles = im2bw(im,0.2);


% Iteratively find the connected components. %
for i=1:5
    
    % Find the connected components. %
    im_cc = bwconncomp(im_bw);
    im_cc_bottles = bwconncomp(im_bw_bottles);
    
    % Find the largest connected comp. in the image. %
    numPixels = cellfun(@numel,im_cc.PixelIdxList);
    [biggest,idx] = max(numPixels);
    numPixels_bottles = cellfun(@numel,im_cc_bottles.PixelIdxList);
    [biggest_bottles, idx_bottles] = max(numPixels_bottles);
    
    
    % Make image, negation of conncomp. %
    im_cnn = zeros(size(im_bw));
    im_cnn_bottles = zeros(size(im_bw_bottles));
    
    % Make the conn comp pixels of this as one. %
    im_cnn(im_cc.PixelIdxList{idx}) = 255;
    im_cnn_bottles(im_cc_bottles.PixelIdxList{idx_bottles}) = 255;
    
    % Convert this to binary image and show. %
    im_cnn_bw = im2bw(im_cnn, 0.5);
    im_cnn_bw_bottles = im2bw(im_cnn_bottles, 0.5);
    
    % Find the num of pixels in given conn components. %
    a = find(im_cnn_bw);
    a_bottle = find(im_cnn_bw_bottles);
    size(a_bottle,1);
    figure, imshow(im_cnn_bw_bottles), title('Considering given bottle.')
    if size(a_bottle,1)/size(a,1) < 5
        val = 'Given bottle is not correctly filled.';
        disp(val)
        figure, imshow(im_cnn_bw), title(val)
     
    else
        val = 'Given bottle is correctly filled.';
        disp(val)
        figure, imshow(im_cnn_bw), title(val)
        
    end
    
    % Change the given image by removing the largest cnncomp. %
    im_bw(im_cc.PixelIdxList{idx}) = 0;
    im_bw_bottles(im_cc_bottles.PixelIdxList{idx_bottles}) = 0;
    
end