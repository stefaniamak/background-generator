#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting deployment script..."

# Step 1: Increment build number
echo "📝 Step 1: Incrementing build number in pubspec.yaml..."
current_version=$(grep "^version:" pubspec.yaml | sed 's/version: //')
version_pattern="([0-9]+\.[0-9]+\.[0-9]+)\+([0-9]+)"
if [[ $current_version =~ $version_pattern ]]; then
    base_version="${BASH_REMATCH[1]}"
    build_number="${BASH_REMATCH[2]}"
    new_build_number=$((build_number + 1))
    new_version="${base_version}+${new_build_number}"
    
    # Use sed to replace the version line
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/^version:.*/version: $new_version/" pubspec.yaml
    else
        # Linux
        sed -i "s/^version:.*/version: $new_version/" pubspec.yaml
    fi
    
    echo "   Changed version from $current_version to $new_version"
else
    echo "   ⚠️  Could not parse version format: $current_version"
    exit 1
fi

# Step 2: Commit version increment to main
echo "📦 Step 2: Committing version increment to main..."
rm -rf docs/ 2>/dev/null || true
git add pubspec.yaml
git commit -m "Increment build number to $new_version"

# Step 3: Switch to gh-pages and merge main
echo "🌿 Step 3: Switching to gh-pages branch..."
# Clean any temporary files that might block branch switch
git checkout .dart_tool/package_graph.json .DS_Store 2>/dev/null || true
git checkout gh-pages || git checkout -b gh-pages

echo "🔀 Step 4: Merging main into gh-pages..."
# Use theirs strategy for .DS_Store and .dart_tool files to avoid conflicts
git merge main -m "Merge main into gh-pages" -X theirs || {
    echo "   Merge conflict detected, accepting theirs and continuing..."
    git checkout --theirs .DS_Store .dart_tool/package_graph.json 2>/dev/null || true
    git checkout --ours docs/ 2>/dev/null || true
    git add .
    git commit -m "Merge main into gh-pages (resolved conflicts)" || true
}

# Step 5: Run dart generate and build on gh-pages branch
echo "🎯 Step 5: Running dart generate on gh-pages..."
dart run isolate_manager:generate

echo "🏗️  Step 6: Building web on gh-pages branch..."
# Clean old build to ensure fresh build
rm -rf build/web
flutter build web

# Step 7: Remove base href from index.html
echo "🔧 Step 7: Removing base href from index.html..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - remove the line containing base href
    sed -i '' '/<base href="\/">/d' build/web/index.html
else
    # Linux - remove the line containing base href
    sed -i '/<base href="\/">/d' build/web/index.html
fi
echo "   ✅ Removed <base href=\"/\"> from index.html"

# Step 8: Update docs folder with the built files
echo "📂 Step 8: Copying build/web to docs folder..."
# Remove ALL contents from docs folder (including hidden files)
echo "   Removing all old files from docs/..."
if [ -d docs ]; then
    find docs -mindepth 1 -delete 2>/dev/null || true
fi

# Ensure docs folder exists
mkdir -p docs

# Copy all files from build/web to docs
echo "   Copying files from build/web to docs/..."
cp -r build/web/. docs/

echo "   ✅ Docs folder updated successfully"

# Step 9: Stage all changes and commit in one go
echo "📦 Step 9: Committing all changes (version and docs) to gh-pages..."
git add .
git commit -m "Deploy build $new_version" || echo "   No changes to commit"

# Step 10: Push to gh-pages
echo "⬆️  Step 10: Pushing to gh-pages..."
git push origin gh-pages

# Step 11: Switch back to main
echo "🔄 Step 11: Switching back to main branch..."
git checkout main

echo "✅ Deployment complete! Version $new_version has been deployed to gh-pages."
echo "   All changes committed in a single commit on gh-pages branch."

