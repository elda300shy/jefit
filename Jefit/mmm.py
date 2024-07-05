import os
import shutil

# Define the main directory and class names
main_dir = 'data/train'
class_names = ['class1', 'class2']  # Replace with your actual class names

# Create the main directory if it doesn't exist
if not os.path.exists(main_dir):
    os.makedirs(main_dir)

# Create subdirectories for each class
for class_name in class_names:
    class_dir = os.path.join(main_dir, class_name)
    if not os.path.exists(class_dir):
        os.makedirs(class_dir)
