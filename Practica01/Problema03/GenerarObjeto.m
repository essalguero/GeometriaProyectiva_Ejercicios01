% Esta funcion genera el poliedro utilizado en todas los apartados de este
% ejercicio a partir de los tres puntos pasados como parámetros

function verticesObject = GenerarObjeto(P, Q, R)

  mVertices = [P; R; Q];


% Apartado a - Generar Poliedro - Son dos piramides unidas por la base

  %Definir el angulo
  angle = pi / 2;

  %Rotar pi/2 alrededor de y
  mRotY = [cos(angle), 0, sin(angle), 0;
           0, 1, 0, 0;
           -sin(angle), 0, cos(angle), 0;
           0, 0, 0, 1];
        
  puntosRotados = [P, 1; Q, 1; R, 1]';

  for i = [1:3]
    puntosRotados = mRotY * puntosRotados;
    mVertices = [mVertices; puntosRotados(1:3, 2)'];
  end
  
  verticesObject = mVertices;
  
end