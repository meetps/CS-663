%%
% From the Question it is very clear that the relation between the blur kernel and the image is :
%
% $$g_1 = f_1 + f_2 * h_2$$
% 
% $g_2 = f_1 * h_1 + f_2$
%
% When we take Fourier Transform on both sides of the equation we get :
%
% $G_1 = F_1 + F_2 H_2$ and $G_2 = F_1 H_1 + F_2$
%
%
% We solve the above equations.
%
% We get the following as the solution for $F_1$ and $F_2$ :
%
% $F_1 = \frac{H_2 G_2 - G_1}{H_1 H_2 - 1},$  and $F_2 = \frac{H_1 G_1 - G_2}{H_1 H_2 - 1}$
%
% and the time domain relation as the following :
%
% $f_1 = \mathcal{F}^{-1}(F_1)$ and $f_2 = \mathcal{F}^{-1}(F_2)$ 
%
% The filters are similar to wiener filters (inverse filters in general) 
% and like all inverse filters they tend to increase indefinitely when the 
% denominator is approaching zero. Here in this case it will reach a
% similar situation when $H_1H_1$ tends to 1. This one of the shortcomings
% of this technique for reflection removal.
%
% But we always have some noise associated with the images (generally)
% additve in nature and hence the actual relation between the kernel and
% the image can be written as follows:
%
% $g_1 = f_1 + f_2 * h_2 + noise_1$
%
% $g_2 = f_1 * h_1 + f_2 + noise_2$
%
% The noise variables are independent and random in nature and it is not 
% possible estimate both $noise_1$ and $noise_2$ with the data at helm.
% 
