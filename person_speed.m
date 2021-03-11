function [vel_hor, vel_ver] = person_speed(frame1, frame2)

%For First Argument

curr_frame_1 = read_gray(frame1);

[sequence_name_next, frame_next] = parse_frame_name(frame1);
filename = make_frame_name(sequence_name_next, frame_next+15);
next_frame_1 = read_gray(filename);

[sequence_name, frame] = parse_frame_name(frame1);
filename2 = make_frame_name(sequence_name, frame-15);
prev_frame_1 = read_gray(filename2);

diff1 = abs(curr_frame_1 - prev_frame_1);
diff2 = abs(curr_frame_1 - next_frame_1);
motion_1 = min(diff1, diff2);

threshold = 10; 
thresholded = (motion_1 > threshold); 

[labels, number] = bwlabel(thresholded, 4);

counters = zeros(1,number);
for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
end

[area, id] = max(counters);    
person1 = (labels == id);

[rows, cols] = size(person1);
 sum_i = 0;
 sum_j = 0;
 counter = 0;
 
 for i = 1:rows;
     for j = 1:cols
         if person1(i,j) ~= 0
             sum_i = sum_i + i;
             sum_j = sum_j + j;
             counter = counter + 1;
         end
     end
 end
 
center_i_1 = sum_i / counter;
center_j_1 = sum_j / counter;
%disp([center_i_1 center_j_1]);

length1 = size(frame1, 2);
frame_string = frame1((length1-7):(length1-4));
frame_num_1 = strread(frame_string)

% For Second Argument

curr_frame_2 = read_gray(frame2);

[sequence_name_next, frame_next] = parse_frame_name(frame2);
filename = make_frame_name(sequence_name_next, frame_next+15);
next_frame_2 = read_gray(filename);

[sequence_name, frame] = parse_frame_name(frame2);
filename2 = make_frame_name(sequence_name, frame-15);
prev_frame_2 = read_gray(filename2);

diff1 = abs(curr_frame_2 - prev_frame_2);
diff2 = abs(curr_frame_2 - next_frame_2);
motion_2 = min(diff1, diff2);

threshold = 10; 
thresholded = (motion_2 > threshold); 

[labels, number] = bwlabel(thresholded, 4);

counters = zeros(1,number);
for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
end

[area, id] = max(counters);    
person2 = (labels == id);

[rows, cols] = size(person2);
 sum_i = 0;
 sum_j = 0;
 counter = 0;
 
 for i = 1:rows;
     for j = 1:cols
         if person2(i,j) ~= 0
             sum_i = sum_i + i;
             sum_j = sum_j + j;
             counter = counter + 1;
         end
     end
 end
 
center_i_2 = sum_i / counter;
center_j_2 = sum_j / counter;
%disp([center_i_2 center_j_2]);

length2 = size(frame2, 2);
frame_string = frame2((length2-7):(length2-4));
frame_num_2 = strread(frame_string)

frame_diff = abs(frame_num_2 - frame_num_1);
%disp(frame_diff);

vel_hor = (center_i_2 - center_i_1)/ frame_diff;
vel_ver = (center_j_2 - center_j_1)/ frame_diff;

 

