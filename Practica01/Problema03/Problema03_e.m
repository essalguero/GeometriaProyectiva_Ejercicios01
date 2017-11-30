% Proyectar objeto
clf;
clear;

P = [0, 1, 0];
Q = [1, 0, 0];
R = [0, -1, 0];

xlabel('x')
ylabel('y')
zlabel('z')

%Centro de la camara
C = [0, 0, 1];

%Posicion de la pantalla
Pantalla = [1, 0, 0]

%Vector de traslacion del objeto
v = [6, 2, 0]

%Genera el objeto inicial   
verticesObject = GenerarObjeto(P, Q, R);
   
% Definir las caras del modelo - Vertices orientados sentido antihorario
faces = [6, 3, 1; 6, 1, 5; 6, 5, 2; 6, 2, 3; ...
         4, 1, 3; 4, 5, 1; 4, 2, 5; 4, 3, 2];
         
%%Dibujar Modelo original         
%patch ('vertices', verticesObject, 'Faces', faces, ...
%'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
%'FaceColor', 'flat');
%
%hold on

%Trasladar el objeto a la posición indicada en el enunciado
mVerticesObject = zeros(4, 6);
mVerticesObject(1:4, 1:6) = 1;
mVerticesObject(1:3, 1:6) = verticesObject';

mTraslacion = eye(4, 4);
mTraslacion(1:3, 4) = v';

mVerticesTrasladados = mTraslacion * mVerticesObject;

%Dibujar la figura trasladada
patch ('vertices', mVerticesTrasladados(1:3, 1:6)', 'Faces', faces, ...
'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
'FaceColor', 'flat');

hold on

%Obtener la proyeccion de la cámara
matrizProyeccion = Problema03_d(C, Pantalla);

verticesProyectados = matrizProyeccion * mVerticesTrasladados;

% Calcular la proyeccion de todos los puntos

for i = 1:6
  
  % Proyectar la cara

  f = verticesProyectados(3, i);
  verticesProyectados(1, i) = verticesProyectados(1, i) / f;
  verticesProyectados(2, i) = verticesProyectados(2, i) / f;
  verticesProyectados(3, i) = verticesProyectados(3, i) / f;
 
end 

% Chequear si la cara es visible

% visibles guarda las caras que se pueden ver desde la posicion actual (1)   
visibles = [0 0 0 0 0 0 0 0];

for i = 1:8
  
  %Calcular 2 aristas que forman la cara
  index1 = faces(i, 2);
  index2 = faces(i, 3);
  index3 = faces(i, 1);
  v1 = mVerticesTrasladados(1:3, index3) - mVerticesTrasladados(1:3, index1);
  v2 = mVerticesTrasladados(1:3, index3) - mVerticesTrasladados(1:3, index2);

  %Producto vectorial para obtener la normal
  normalVector = crossProduct3d(v1', v2);

  productoEscalar = mVerticesTrasladados(1:3, index3)' * normalVector;
  
  %La cara es visible si el producto escalar es negativo
  if productoEscalar < 0
    
    visibles(i) = 1;
    
    % Es visible. Pintarla
    
  endif
end


%Crear un vector que indique que caras hay que pintar
numeroCaras = 0;

for i = 1:8
  if visibles(i) == 1
    numeroCaras = numeroCaras + 1;
  endif
end

carasAPintar = eye(numeroCaras, 3);
contador = 0;
for i = 1:8
  if visibles(i) == 1
    contador = contador + 1;
    
    carasAPintar(contador, 1:3) = faces(i, 1:3);
  endif
end

%Pintar el objeto proyectado
verticesProyectados = verticesProyectados(1:3, 1:6)'

patch ('vertices', verticesProyectados, 'Faces', carasAPintar, ...
'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
'FaceColor', 'flat');

text(verticesProyectados(1, 1), verticesProyectados(2, 1), verticesProyectados(3, 1),...
     "Objeto proyectado")

     
hold off