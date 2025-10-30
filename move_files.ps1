# Move all files and folders from AdminServerStub to the root directory
$source = "C:\Users\ASUS\Desktop\ServerNew\AdminServerStub\*"
$destination = "C:\Users\ASUS\Desktop\ServerNew\"

# Copy all files and folders
Copy-Item -Path $source -Destination $destination -Recurse -Force

# Remove the now empty AdminServerStub directory
Remove-Item -Path "C:\Users\ASUS\Desktop\ServerNew\AdminServerStub" -Recurse -Force

# Remove Git submodule reference if it exists
git rm --cached AdminServerStub 2>$null
Remove-Item -Path ".git\modules\AdminServerStub" -Recurse -Force -ErrorAction SilentlyContinue

# Add all files to Git
git add .

# Commit the changes
git commit -m "Move project files to root directory"

git push origin main
