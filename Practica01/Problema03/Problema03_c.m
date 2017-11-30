%Realizar proyeccion del objeto sobre plano z = 1
%La instruccion para dibujar el objeto inicial ha sido comentada. Se puede 
%descomentar para apreciar mejor los cambios al realizar la proyección
clf;
clear;

P = [0, 1, 0];
Q = [1, 0, 0];
R = [0, -1, 0];

xlabel('x')
ylabel('y')
zlabel('z')

verticesObject = GenerarObjeto(P, Q, R);

view (-37.5, 30);

hold on

%Dibujar el objeto - Es un diamante (formado por dos piramides)
faces = [6, 3, 1; 6, 1, 5; 6, 5, 2; 6, 2, 3; ...
         4, 1, 3; 4, 5, 1; 4, 2, 5; 4, 3, 2];

%Apartado c - Trasladar y proyectar

%Generar matriz de traslacion
vTraslacion = [0, 1, 4];

mTraslacion = eye(4, 4);
mTraslacion(1:3, 4) = vTraslacion';

%Generar una matriz con los vertices
verticesTrasladar = eye(6, 4);
verticesTrasladar(1:6, 1:3) = verticesObject;
verticesTrasladar(1:6, 4) = 1;

verticesTrasladados = mTraslacion * [verticesTrasladar]';
verticesTrasladadosPintar = verticesTrasladados(1:3, 1:6)';
%patch ('vertices', verticesTrasladadosPintar, 'Faces', faces, ...
%'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
%'FaceColor', 'flat');

hold on

xlabel('x')
ylabel('y')
zlabel('z')


vPosicion = [0, 0, 0];

visibles = [0 0 0 0 0 0 0 0];

for i = 1:6
  
  % Proyectar la cara
  f = 1;
  fX = f / verticesTrasladados(3, i);
  fY = f / verticesTrasladados(3, i);
  fZ = 1 / verticesTrasladados(3, i);
  
  mProyeccionZ1 = [fX, 0, 0, 0; 0, fY, 0, 0; 0, 0, fZ, 0];
  nuevoVertice = mProyeccionZ1 * verticesTrasladados(1:4, i);
  verticesProyectados(1:3, i) = nuevoVertice;
 
end 

% Chequear si la cara es visible. Utilizar producto Escalar
for i = 1:8
  
  % Obtener vector Normal al plano de la cara
  index1 = faces(i, 2);
  index2 = faces(i, 3);
  index3 = faces(i, 1);
  v1 = verticesTrasladados(1:3, index3) - verticesTrasladados(1:3, index1);
  v2 = verticesTrasladados(1:3, index3) - verticesTrasladados(1:3, index2);

  vResult = crossProduct3d(v1', v2);

  %Producto escalar entre el vector de posición y el normal
  productoEscalar = verticesTrasladados(1:3, index3)' * vResult;
  
  if productoEscalar < 0
    
    visibles(i) = 1;
    
    % Es visible. Pintarla
    
  endif
end

%Buscar caras visibles
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


% Eliminar la cuarta componente de los puntos
verticesProyectados = verticesProyectados(1:3, 1:6)';

patch ('vertices', verticesProyectados, 'Faces', carasAPintar, ...
'FaceVertexCData', [1 0 0; 0 1 0; 0 0 1; 1 0 1],...
'FaceColor', 'flat');

text(0.00000, 0.50000, 1.00000, "0.00000, 0.50000, 1.00000")
text(0.00000, 0.00000, 1.00000, "0.00000, 0.00000, 1.00000")
text(0.25000, 0.25000, 1.00000, "0.25000, 0.25000, 1.00000")
text(0.00000, 0.33333, 1.00000, "0.00000, 0.33333, 1.00000")
text(-0.25000, 0.25000, 1.00000, "-0.25000, 0.25000, 1.00000")
%text(-0.00000, 0.20000, 1.00000, "-0.00000, 0.20000, 1.00000")

visibles

view(0,0)

hold off




