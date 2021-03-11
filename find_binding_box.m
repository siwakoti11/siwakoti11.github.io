function [top,bottom,left,right] = find_binding_box(frame1)

original_image = imread(frame1);

curr_frame = read_gray(frame1);

[sequence_name_next, frame_next] = parse_frame_name(frame1);
filename = make_frame_name(sequence_name_next, frame_next+15);
next_frame = read_gray(filename);

[sequence_name, frame] = parse_frame_name(frame1);
filename2 = make_frame_name(sequence_name, frame-15);
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

info = regionprops(person,'Boundingbox');
imshow(original_image);
hold on
for k = 1 : length(info)
      BB = info(k).BoundingBox;
      rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','y','LineWidth',2) ;
end

disp(BB(1));
disp(BB(2));
disp(info);

top = BB(2);
bottom = (BB(2)+BB(4));
left = BB(1);
right = (BB(1) + BB(3));



