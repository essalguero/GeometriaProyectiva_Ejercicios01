% Dibujar el objeto en pantalla
clf;
clear;

P = [0, 1, 0];
Q = [1, 0, 0];
R = [0, -1, 0];

xlabel('x')
ylabel('y')
zlabel('z')


%Generar todos los vertices del objeto
verticesObject = GenerarObjeto(P, Q, R);

%Dibujar el objeto - Es un diamante (formado por dos piramides)
faces = [6, 3, 1; 6, 1, 5; 6, 5, 2; 6, 2, 3; ...
         4, 1, 3; 4, 5, 1; 4, 2, 5; 4, 3, 2]
patch ('vertices', verticesObject, 'Faces', faces, ...
'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
'FaceColor', 'flat');

axis equal
hold off