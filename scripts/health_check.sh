
#!/bin/bash

echo "================================"
echo "     SYSTEM HEALTH CHECK"
echo "================================"

echo "Checking Python installation..."

python3 --version

if [ $? -eq 0 ]; then
    echo "Python is installed successfully."
else
    echo "Python installation failed."
    exit 1
fi

echo "Checking project files..."

if [ -f "app/app.py" ]; then
    echo "Flask application found."
else
    echo "Flask application missing."
    exit 1
fi

if [ -f "tests/test_app.py" ]; then
    echo "Unit test file found."
else
    echo "Unit test file missing."
    exit 1
fi

echo "================================"
echo "     HEALTH CHECK PASSED"
echo "================================"