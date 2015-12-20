%% Single Dimension Image Retrieval
% 
% We know that $$h$ is the convolutional kernel for gradient operation, we take the Fourier Transform to get :
%
% $$G = F H$$
% 
% T0 obtain the image we divide $G$ by $H$ to get $F$ but then as in Q.2 we will face the same problem in which
% $F$ tend to infinty as $H$ tends to zero. Also we haven't considered the possibility of an additive noise being
% present in the image
%
% The presence of noise in the image changes the recovery process as : 
% 
% $$G = F H + Noise$
%
% Solving to get F we get $Noise$ in the denominator and hence the image results screw up when $H$ is less compared 
% $N$.
%
% In the case of 2D images we have :
% 
% $$G_x = F H_x$ and $$G_y = F H_y$  
% 
% An acccurate way to represnt $F$ would be  :
%
% $$F = \frac{G_x - G_y}{H_x - H_y}$
%
% A few advanctages that we have in this case are : 
% We can use the values of $H_x$ and $H_y$ whenever one of them blows up to estimate the other one and hence prevent 
% the image $F$ from screwing up whenever $H$ tends to zero. Secondly in the formula for $F$ above the noise removal is
% intrinsic as we have used the gradient components of $G$ and $H$ to obtain $F$.
% 
% A few problems that we can percieve are that whenever the $H_y$ and $H_x$ are both tending to zero , $F$ screws up again.
% Secondly we assume that noise is additive in nature and hence we use the formula as above, had the noise been of different 
% signs in different gradients , the above formula will cause the noise in both directions to be increased rather than being 
% sidelined.
% 
