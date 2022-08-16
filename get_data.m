% This program reads signal express  data (usually saved as text files)
clear;clc;close all
[fileName1, pathName1] = uigetfile('*.txt');
G = load(fullfile(pathName1,fileName1));

