function result = person_present(frame1)

original_image = imread(frame1);

curr_frame = read_gray(frame1);

[sequence_name_next, frame_next] = parse_frame_name(frame1);
filename = make_frame_name(sequence_name_next, frame_next+2);
next_frame = read_gray(filename);

[sequence_name, frame] = parse_frame_name(frame1);
filename2 = make_frame_name(sequence_name, frame-2);
prev_frame = read_gray(filename2);

diff1 = abs(curr_frame - prev_frame);
diff2 = abs(curr_frame - next_frame);
motion = min(diff1, diff2);

threshold = 10; 
thresholded = (motion > threshold); 

[labels, number] = bwlabel(thresholded, 4);

counters = zeros(1,number);
for i = 1:number
    component_image = (labels == i);
    counters(i) = sum(component_image(:));
end

[area, id] = max(counters);    
person = (labels == id);
%imshow(person, []);
%disp(area);

if area < 10 %condition where the area of the connected components is less than 10 which includes just the shadow of the person or a small portion of his shoe being visible or absence of person in the frame
    result = 0;
else         %condition where the area of connected components is greater thean 10 which includes a small portion of the person being visible to the person being fully visible 
    result = 1;
end



