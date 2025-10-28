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
git add pubspec.yaml
git commit -m "Increment build number to $new_version"

# Step 3: Switch to gh-pages and merge main
echo "🌿 Step 3: Switching to gh-pages branch..."
git checkout gh-pages || git checkout -b gh-pages

echo "🔀 Step 4: Merging main into gh-pages..."
git merge main -m "Merge main into gh-pages"

# Step 5: Run dart generate and build on gh-pages branch
echo "🎯 Step 5: Running dart generate..."
dart run isolate_manager:generate

echo "🏗️  Step 6: Building web on gh-pages branch..."
flutter build web

# Step 7: Update docs folder with the built files
echo "📂 Step 7: Copying build/web to docs folder..."
# Remove ALL contents from docs folder (including hidden files)
echo "   Removing all old files from docs/..."
rm -rf docs/* 2>/dev/null || true
find docs -mindepth 1 -maxdepth 1 -exec rm -rf {} + 2>/dev/null || true

# Ensure docs folder exists
mkdir -p docs

# Copy all files from build/web to docs
echo "   Copying files from build/web to docs/..."
cp -r build/web/. docs/

echo "   ✅ Docs folder updated successfully"

# Step 8: Stage all changes and commit in one go
echo "📦 Step 8: Committing all changes (version and docs) to gh-pages..."
git add .
git commit -m "Deploy build $new_version" || echo "   No changes to commit"

# Step 9: Push to gh-pages
echo "⬆️  Step 9: Pushing to gh-pages..."
git push origin gh-pages

# Step 10: Switch back to main
echo "🔄 Step 10: Switching back to main branch..."
git checkout main

echo "✅ Deployment complete! Version $new_version has been deployed to gh-pages."
echo "   All changes committed in a single commit on gh-pages branch."

