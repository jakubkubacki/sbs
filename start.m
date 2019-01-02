clc; clear; close all;

innerPointsLen = 500;
step = 0.1;
maxLoop = 15000;
filePath = './images/bone-1.png';
filePath2 = './images/bone-2.png';

simulationState = runSimulation(innerPointsLen, step, maxLoop, filePath, filePath2);
