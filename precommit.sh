#!/bin/bash
# TODO: Enforce clang-tidy on commit

pre-commit install

pre-commit clean

{
cat << 'EOF'
#!/bin/bash

#
# CPP Format and Lint
#

echo "Start: CPP Format and Lint"

echo "Execute: clang-format"
cpp_format_all() {
    find . -path ./build -prune -o -name \"*.cpp\" -print -exec clang-format -i {} +
}

cpp_format_all

echo "Execute: clang-tidy"
cpp_lint_all() {
    find src -name "*.cpp" -exec clang-tidy {} -header-filter=.* -system-headers=false -p build --checks=* \;
}

cpp_lint_all

if [ $? -ne 0 ]; then
    echo "Error: clang-tidy failed."
    exit 1
fi

echo "Complete: CPP Format and Lint"

#
# Pre-Commit
#

EOF

cat .git/hooks/pre-commit

} > .git/hooks/pre-commit.tmp

mv .git/hooks/pre-commit.tmp .git/hooks/pre-commit

sudo chmod +x .git/hooks/pre-commit

echo "Success: Appended CPP format and lint"
