function [all_theta] = oneVsAll(X, y, num_labels, lambda)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logistic regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i

% m guarda numero de filas n guarda numero de columnas
[m,n] = size(X);

% 10x401 
all_theta = zeros(num_labels, n + 1);

% Add ones to the X data matrix
X = [ones(m, 1) X];

% largo de filas igual a cantidad de variables + 1. queda:  401x1
initial_theta = zeros(n + 1, 1);

% options = optimset('param1',value1,'param2',value2,...)
% parametro gradobj prendido, max iter 50
% optimset es una estructura de opciones
options = optimset('GradObj', 'on', 'MaxIter', 50);

% para c de 1 a 10
for c = 1:num_labels
% theta(:) will return a column vector.
% va guardadndo en cada fila el vector columna

% y==c en verdad lo que hace es pasarle un vector logico formado por 1 y 0 si
% los elementos coinciden o no
  vectorLogico = ( y == c );
  
  % fmincg minimiza la funcion costos, y me devuelve ls thetas,
  % es como un gradiente por descenso, pero optimizado e inteligente
  % es parecida a fminunc pero mas eficiente cuando hay muchos parametros
  % pero es menos precisa
  all_theta(c,:) = fmincg (@(t)(lrCostFunction(t, X, vectorLogico, lambda)), initial_theta, options);

end
