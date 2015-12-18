function [dTanh]=derivTanh(input)

    dTanh = 1 - (tanh(input).^2);

return;