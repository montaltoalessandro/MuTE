%% DERIVSIGMOID derivate of standard logistic function
% [sig] = derivSigmoid(x)
% x: matrix n x m [x11, ..., x1m; ...; xn1, ..., xnm]
% dsig: matrix n x m [sigmoid(x11)(1-sigmoid(x11)), ..., sigmoid(x1m)(1-sigmoid(x1m)); ...; sigmoid(xn1)(1-sigmoid(xn1)), ..., sigmoid(xnm)(1-sigmoid(xnm))]

function  [dsig] = derivSigmoid (x)

dsig = sigmoid(x).*(ones(size(x))-sigmoid(x));

end