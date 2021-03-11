restoredefaultpath;
clear all;
close all;

addpath 'D:\School\Spring 2021\CSE 4310\all_code\00_detection'
addpath 'D:\School\Spring 2021\CSE 4310\all_code\00_images'
addpath 'D:\School\Spring 2021\CSE 4310\all_code\00_utilities'
addpath 'D:\School\Spring 2021\CSE 4310\all_code\all_code\01_intro'
addpath 'D:\School\Spring 2021\CSE 4310\HW2'
cd 'D:\School\Spring 2021\CSE 4310\HW2\1_intro_data'

[vel_hor, vel_ver] = person_speed('walkstraight/frame0052.tif','walkstraight/frame0062.tif');
disp([vel_hor vel_ver]);

[top, bottom, left, right] = find_binding_box('walkstraight/frame0062.tif');
disp([top bottom left right]);

result = person_present('walkstraight/frame0002.tif');
disp(result);