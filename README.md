# Tracking_nucleus
This code is to generate a movie of an single nucleus from a live cell movie containing mutiple nuclei.
It will take a region (256x256 pixels) containing an individual nucleus in each time frame, and save as tiff z-stacks.
With the current setting, input file needs to be two color images (dv format).
Output files are movies(tiff) of an individual nucleus generated from 1 original live cell movie & a picture of numbered nuclei.
Each movie is numbered as shown in the picture as a reference.
To run the code, download all m-files, and run crop_nuc_2.m
