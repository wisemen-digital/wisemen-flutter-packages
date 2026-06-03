# Generate openapi from docs

This package needs a generated network package named openapi. To generate it, create this path packages/generated_network and run this command:
```sh 
openapi-generator generate -i {link-to-json} -g dart-dio --skip-validate-spec
```
After generating this package needs to be updated to work with the latest version of Flutter and our packages.

# Flutter commands

1. update min sdk version in pubspec, it should look like this (versions might be outdated, update these)
```yaml
name: openapi
version: 1.0.0
description: OpenAPI API client
homepage: homepage
publish_to: none

environment:
  sdk: '>=3.10.0 <4.0.0'
resolution: workspace
dependencies:
  dio: '^5.7.0'
  one_of: '>=1.5.0 <2.0.0'
  one_of_serializer: '>=1.5.0 <2.0.0'
  built_value: '>=8.4.0 <9.0.0'
  built_collection: '>=5.1.1 <6.0.0'

dev_dependencies:
  built_value_generator: '>=8.4.0 <9.0.0'
  build_runner: any
  test: '^1.16.0'
```

2. run pub upgrade
3. build generated files

Fix naming issues (reserved names like `name` in dart aren't all escaped, should present themselves as errors)

4. dart fix --apply
5. dart format .

Now we can create interfaces and mocked models for the parts of the api we use (used by repository service) in this package (network/source)
