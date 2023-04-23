function thresh= fuzzyThresholding(image, maxIter)
% FUZZYTHRESHOLDING computes a fuzzy threshold for the input image using
% the maximum entropy principle.
% 
% INPUT:
%   - image: the input grayscale image
%   - maxIter: maximum number of iterations for the fuzzy c-means algorithm
%
% OUTPUT:
%   - thresh: the computed threshold
%   - fuzzy_image: the fuzzy membership of each pixel to the two classes
%
% EXAMPLE USAGE:
%   I = imread('cameraman.tif');
%   [T, M] = fuzzyThresholding(I, 100);

% Convert image to double precision
%image = im2double(image);

% Set initial threshold
thresh = 0.5;

% Initialize membership vectors
u1 = ones(size(image));
u2 = ones(size(image));

for i = 1:maxIter
    % Update membership vectors
    u1 = exp(-(image - thresh).^2);
    u2 = exp(-(image - (1-thresh)).^2);

    % Normalize membership vectors
    u1 = u1 ./ (u1 + u2);
    u2 = u2 ./ (u1 + u2);

    % Update threshold
    thresh = sum(sum(u1 .* image)) / sum(sum(u1));

    % Compute fuzzy image
    fuzzy_image = cat(3, u1, u2);

    % Exit early if the threshold has converged
    if abs(thresh - 0.5) < 1e-6
        break;
    end
end

end