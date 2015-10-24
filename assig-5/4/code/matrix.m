%% Matrix Proofs and Problems
%
%% Part a
% Consider a matrix $\textbf{A}$ of size $m \times n$. 	Define $\textbf{P}=\textbf{A}^T \textbf{A}$ and $\textbf{Q}=\textbf{A} \textbf{A}^T$.
%
% Now, if $$\textbf{A}$$ has dimensions $m \times n$, $\textbf{P}$ has dimensions $n \times n$. Hence if we want to evaluate 
% $\textbf{y}^T \textbf{P} \textbf{y}$ for a (column) vector $\textbf{y}$, $\textbf{y}$ must have dimensions $n \times 1$. 
% This means the product $\textbf{y}^T \textbf{P} \textbf{y}$ will be a scalar.
%
% Now we have $\textbf{y}^T \textbf{P} \textbf{y} = \textbf{y}^T \textbf{A}^T \textbf{A} \textbf{y}$
% Putting $\textbf{Z} = \textbf{A}\textbf{y}$, and noticing that $\textbf{Z}^T = \textbf{y}^T \textbf{A}^T$, we have 
% $$\textbf{y}^T \textbf{P} \textbf{y} = \textbf{Z}^T \textbf{Z}$
% Thus the given expression is the dot product of a vector with itself, which is always non-negative. Thus, 
% $$\textbf{y}^T \textbf{P} \textbf{y} \geq 0$
% 
% Similarly, we have for a $n \times 1$ vector $\textbf{z}$, with $\textbf{Y} = \textbf{A}\textbf{z}$ 
% $$\textbf{z}^T \textbf{Q} \textbf{z} = \textbf{Y}^T \textbf{Y}$
% 
% which is again the dot product of a vector with itself, which is always non-negative. Thus, $$\textbf{z}^T \textbf{Q} \textbf{z} \geq 0$
%
% Now consider an eigenvector $\textbf{z}$ of $\textbf{A}^T \textbf{A}$, where $\textbf{z}$ is a $m \times 1$ vector. We must have for some
% $\lambda$ $$\textbf{A}^T \textbf{A} \textbf{z} = \lambda \textbf{z}$
% 
% A pre-multiplication by $\textbf{z}^T$ yields
% $$\textbf{z}^T \textbf{A}^T \textbf{A} \textbf{z} = \textbf{z}^T \lambda \textbf{z}$
% 
% which means
% $$\textbf{z}^T \textbf{A}^T \textbf{A} \textbf{z} = \lambda \textbf{z}^T \textbf{z}$
% 
% Now the left hand side is positive, as proved above. $\textbf{z}^T \textbf{z}$ is positive,
 % because it is the dot product of a vector with itself. Hence, $\lambda$ must be non-negative.
%
% Similarly for $\textbf{A} \textbf{A}^T$, consider an eigenvector $\textbf{z}$ of dimension $m \times 1$. 
% Multiplying the eigenvalue equation on the left by $\textbf{z}^T$ we get for some $\lambda$
% $$\textbf{z}^T \textbf{A} \textbf{A}^T \textbf{z} = \lambda \textbf{z}^T \textbf{z}$
% which again means $\lambda$ is non-negative.
% 
% Hence the eigenvalues of $\textbf{A}^T \textbf{A}$ and $\textbf{A} \textbf{A}^T$ are non-negative.
% 
%% Part b
% If $\textbf{u}$ is an eigenvector of $\textbf{P}$ with eigenvalue $\lambda$, we have
% $$\textbf{A}^T \textbf{A} \textbf{u} = \lambda \textbf{u}$
% Pre-multiply by $\textbf{A}^T$ to give
% 
% $$\textbf{A} \textbf{A}^T \textbf{A} \textbf{u} = \textbf{A} \lambda \textbf{u}$
% 
% implying
% $$\textbf{A} \textbf{A}^T \textbf{A} \textbf{u} = \lambda \textbf{A} \textbf{u}$
% Thus $\textbf{Au}$ is an eigenvector of \textbf{Q} with eigenvalue $\lambda$.
% 
% Similarly, if $\textbf{v}$ is an eigenvector of $\textbf{Q}$ with eigenvalue $\mu$, we have by pre-multiplying with $\textbf{A}^T$
% 
% $$\textbf{A}^T \textbf{A} \textbf{A}^T \textbf{v} = \mu \textbf{A}^T \textbf{v}$
% 
% Thus $\textbf{A}^T \textbf{v}$ is an eigenvector of $\textbf{P}$ with eigenvalue $\mu$.
% 
% Clearly $\textbf{u}$ has $n$ elements and $\textbf{v}$ has $m$ elements.
% 
%% Part c
% If $\textbf{v}_i$ is an eigenvector of $\textbf{Q}$, we have
% $$\textbf{AA}^T \textbf{v}_i = \lambda_i \textbf{v}_i$
% Defining $\textbf{u}_i$ as $$\textbf{u}_i = \frac{\textbf{A}^T \textbf{v}_i}{||\textbf{A}^T \textbf{v}_i||}$
% and substituting it in the previous equation yields 
% 
% $$\textbf{Au}_i = \frac{\lambda_i}{||\textbf{A}^T \textbf{v}_i||} \textbf{v}_i$
% 
% 
% Define $\gamma_i$ as $$\gamma_i = \frac{\lambda_i}{||\textbf{A}^T \textbf{v}_i||}$
% 
% Clearly $\gamma_i$ are non-negative because $\lambda_i$ are non-negative and the denominator being a norm is non-negative as well.
% 
% Thus there exist some real, non-negative $\gamma_i$ which satisfy
% $$\textbf{Au}_i = \gamma_i \textbf{u}_i$$
% 
%% Part d
% 
% Consider the product $\textbf{U} \Gamma \textbf{V}^T$ with the matrices as defined in the question. 
% 
% We have
% 
% Thus
% 
% $$\textbf{U} \Gamma = [ \gamma_1 \textbf{v}_1 | \gamma_2 \textbf{v}_2 | \cdots | \gamma_m \textbf{v}_m ]$
% 
% From the previous part each $\gamma_{i} \textbf{v}_i$ can be written as
% $$\gamma_{i} \textbf{v}_i = \textbf{Au}_i$
% 
% Thus $$\textbf{U} \Gamma = [ \textbf{Au}_1 | \textbf{Au}_2 | \cdots | \textbf{Au}_n ]$
% 
% which means
% 
% $$\textbf{U} \Gamma \textbf{V}^T = [ \textbf{Au}_1 | \textbf{Au}_2 | \cdots | \textbf{Au}_n ]  [ \textbf{u}_1 | \textbf{u}_2 | \cdots | \textbf{u}_n ]^T$
% 
% implying
% 
% $$\textbf{U} \Gamma \textbf{V}^T = \textbf{A} [ \textbf{u}_1 | \textbf{u}_2 | \cdots | \textbf{u}_n ]  [ \textbf{u}_1 | \textbf{u}_2 | \cdots | \textbf{u}_n ]^T$
% 
% Now given that $$\textbf{u}_i \textbf{u}_j = \delta_{ij}$ we have
% 
% $$A = \textbf{U} \Gamma \textbf{V}^T$
% where $\Gamma$ is a matrix that has the non-negative $\gamma_i$ on its diagonal elements and zeros on the off-diagonal elements.
% 
% Thus we are done.