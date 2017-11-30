% Caras del objeto visibles desde [10, 2, 1]

clf;
clear;

xlabel('x')
ylabel('y')
zlabel('z')

P = [0, 1, 0];
Q = [1, 0, 0];
R = [0, -1, 0];

%Generar los vértices que forman el objeto
verticesObject = GenerarObjeto(P, Q, R)

%Dibujar el objeto - Es un diamante (formado por dos piramides)
faces = [6, 3, 1; 6, 1, 5; 6, 5, 2; 6, 2, 3; ...
         4, 1, 3; 4, 5, 1; 4, 2, 5; 4, 3, 2]
patch ('vertices', verticesObject, 'Faces', faces, ...
'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
'FaceColor', 'flat');

axis equal
hold on

% Apartado b - Mover la camara a [10, 2, 1] e indicar las caras visibles

# Set the camera as requested [10, 2, 1]
vPosicion = [10, 2, 1]
set(gca,'CameraTarget', [0, 0, 0]);
set(gca,'CameraPosition', vPosicion);
drawnow

% Calcular las caras visibles utilizando producto escalar
for i = [1:8]
  
  %Obtener los vertices de la cara
  index1 = faces(i, 2);
  index2 = faces(i, 3);
  index3 = faces(i, 1);
  
  %Calcular los vectores que unen los vertices
  v1 = verticesObject(index3, 1:3) - verticesObject(index1, 1:3);
  v2 = verticesObject(index3, 1:3) - verticesObject(index2, 1:3);
  
  %Calcular el vector normal usando el producto vectorial
  vResult = crossProduct3d(v1, v2');
  
  %Como miramos desde vPosicion hacia (0, 0, 0),
  %Se usa -vPosicion como vector para el producto escalar
  productoEscalar = -vPosicion * vResult;
  
  % Una cara es visible si el producto escalar de su normal
  % Por el veector de la vista es menor que 0
  if productoEscalar < 0
    printf("Cara %d es visible\n", i);
  else
    printf("Cara %d no es visible\n", i);
  endif
    
end


text(1, 0, 0, "(1, 0, 0)");
text(0, 1, 0, "(0, 1, 0)");
text(0, 0, 1, "(0, 0, 1)");
text(-1, 0, 0, "(-1, 0, 0)");
text(0, -1, 0, "(0, -1, 0)");
text(0, 0, -1, "(0, 0, -1)");

