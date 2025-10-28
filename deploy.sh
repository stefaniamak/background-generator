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

# Step 2: Merge main into gh-pages
echo "🌿 Step 2: Merging main branch into gh-pages..."
git checkout gh-pages || git checkout -b gh-pages
git merge main -m "Merge main into gh-pages"

# Step 3: Run dart generate
echo "🎯 Step 3: Running dart generate..."
dart run isolate_manager:generate

# Step 4: Build web
echo "🏗️  Step 4: Building web..."
flutter build web

# Step 5: Clear docs folder and copy build/web to docs
echo "📂 Step 5: Updating docs folder..."
# Remove all contents from docs folder
rm -rf docs/* docs/.DS_Store 2>/dev/null || true

# Copy all files from build/web to docs
cp -r build/web/. docs/

echo "   Copied build/web/* to docs/"

# Step 6: Stage and commit changes
echo "📦 Step 6: Committing changes..."
git add .
git commit -m "Update docs: Build $new_version" || echo "   No changes to commit"

# Step 7: Push to gh-pages
echo "⬆️  Step 7: Pushing to gh-pages..."
git push origin gh-pages

echo "✅ Deployment complete! Version $new_version has been deployed to gh-pages."

