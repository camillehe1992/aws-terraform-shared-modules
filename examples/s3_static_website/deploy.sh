#!/usr/bin/env bash
set -euo pipefail

BUCKET="demo-static-site-2026" # must match main.tf

echo "Creating sample index.html & 404.html"
mkdir -p site
cat > site/index.html <<'EOF'
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>Demo</title></head>
  <body>
    <h1>Hello from S3 Static Website Hosting!</h1>
  </body>
</html>
EOF

cat > site/404.html <<'EOF'
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>Not found</title></head>
  <body>
    <h1>404 - Page not found</h1>
  </body>
</html>
EOF

echo "Uploading to s3"
aws s3 sync site/ s3://${BUCKET}/ --acl public-read

echo "Done - browse to:"
terraform output -raw bucket_endpoint
