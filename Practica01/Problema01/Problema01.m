% Solución al primer ejercicio
% Las instrucciones para dibujar los pasos intermedios han sido comentadas
% y sólo se representan el objeto inicial y final
% Se pueden descomentar las lineas 46, 47 y 57, 58 si se quiere revisar el 
% proceso seguido

clf;
clear;

cx = [0, 1, 1, 0, 0];
cy = [0, 0, 1, 1, 0];
cz = [1, 1, 1, 1, 1];


vertices = [0, 0; 1, 0; 1, 1; 0, 1];
faces = [1, 2, 3, 4];
patch ('vertices', vertices, 'Faces', faces, ...
'FaceColor', 'flat');
hold on

%Punto alrededor del que se quiere rotar
puntoRotacion = [2, 1];
%plot([puntoRotacion(1)], [puntoRotacion(2)]);
%hold on

% Definir angulo rotacion 45 grados
anguloRotacion = pi / 4;

%Trasladar al origen
vTraslacion = [puntoRotacion * (-1), 1];
mTraslacionOrigen = [1, 0, 0; 0, 1, 0; vTraslacion]';

% Rotar 45 grados
mRotacion = [cos(anguloRotacion), -sin(anguloRotacion), 0; ...
             sin(anguloRotacion), cos(anguloRotacion), 0; ...
             0, 0, 1];
             
mTraslacionVuelta = [1, 0, 0; 0, 1, 0; puntoRotacion, 1]';

mPuntos = [cx; cy; cz];

mPuntosRotados = mTraslacionOrigen * mPuntos;
mPuntosRotados = mRotacion * mPuntosRotados;
mPuntosRotados = mTraslacionVuelta * mPuntosRotados;

%Dibujar intermedio 1
%vertices = [mPuntosRotados(1:2,1:end - 1)]';
%patch ('vertices', vertices, 'Faces', faces, ...
%'FaceColor', 'flat');
%hold on


vTraslacion = [-1, -1, 1];
mTraslacion = [1, 0, 0; 0, 1, 0; vTraslacion]';
mPuntosTrasladados = mTraslacion * mPuntosRotados;

%Dibujar intermedio 2
%vertices = [mPuntosTrasladados(1:2,1:end - 1)]';
%patch ('vertices', vertices, 'Faces', faces, ...
%'FaceColor', 'flat');
%hold on

%Shear
% 2 Unidades ejex
% hipotenusa = sqrt(1^2 + 2^2) = sqrt(5)
% tan = sin / cos = (2/sqrt(5)) / (1/sqrt(5)) = 2

mShear = [1, atan(2), 0; 0, 1, 0; 0, 0, 1];
mPuntosShear = mShear * mPuntosTrasladados;
vertices = [mPuntosShear(1:2,1:end - 1)]';
patch ('vertices', vertices, 'Faces', faces, ...
'FaceColor', 'flat');

hold off



xlabel('x');
ylabel('y');