#!/bin/bash
OUTPUT="coverage/final_coverage.lcov.info"
> $OUTPUT

for package in packages/*/; do
  package_name=$(basename "$package")

  # Check if filtered coverage exists
  if [ -f "$package/coverage/filtered.lcov.info" ]; then
    echo "Processing $package_name"

    # Rewrite the SF: lines
    sed "s|SF:lib|SF:packages/$package_name/lib|g" "$package/coverage/filtered.lcov.info" >> $OUTPUT
  fi
done

echo "Final merged coverage saved to $OUTPUT"
