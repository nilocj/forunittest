## [v0.3.0](https://github.com/gha3mi/forunittest/compare/v0.2.0...v0.3.0) - 2025-08-04


### Features

* feat: add preprocessor macro support for real kind selection ([869d6f5](https://github.com/gha3mi/forunittest/commit/869d6f5657577adc0954503e9807d23a33146e88)) by [@gha3mi](https://github.com/gha3mi)
* feat: added unit_tests derived type with summary (#5) ([c1fda45](https://github.com/gha3mi/forunittest/commit/c1fda457c74fd45b69bd8e176421cc99a3aff3f7)) by [@gha3mi](https://github.com/gha3mi)


### Contributors
- [@gha3mi](https://github.com/gha3mi)



Full Changelog: [v0.2.0...v0.3.0](https://github.com/gha3mi/forunittest/compare/v0.2.0...v0.3.0)

## [v0.2.0](https://github.com/gha3mi/forunittest/compare/v0.1.0...v0.2.0) - 2025-07-22


### Features

* feat: add CMake testing job to CI/CD workflow ([8c79502](https://github.com/gha3mi/forunittest/commit/8c7950267bc1d2bae8e743130511c44e437a7afd)) by [@gha3mi](https://github.com/gha3mi)
* feat: add release script for automated changelog generation and versioning ([e34911f](https://github.com/gha3mi/forunittest/commit/e34911fa47a33fa1524d3d79370402e3ab3429f5)) by [@gha3mi](https://github.com/gha3mi)
* feat: add CI configurations for fpm tests across multiple platforms ([7df56d9](https://github.com/gha3mi/forunittest/commit/7df56d9e0d350553cd409a24b8cba7e9b45e1171)) by [@gha3mi](https://github.com/gha3mi)

### Fixes

* fix: Refactor CMakeLists.txt to improve build options for examples and tests ([bb8c3a0](https://github.com/gha3mi/forunittest/commit/bb8c3a066201983c5c967b5b84c5b71aab6a9f08)) by [@gha3mi](https://github.com/gha3mi)
* fix: add use only ([a8da224](https://github.com/gha3mi/forunittest/commit/a8da224de0c5b05a8069a524e3cec7ca4faf14fa)) by [@gha3mi](https://github.com/gha3mi)
* fix: use FORUNITTEST_BUILD_TESTS flag ([9e4619e](https://github.com/gha3mi/forunittest/commit/9e4619ed711f503b8d9eabeacda262e99f7b4f1b)) by [@gha3mi](https://github.com/gha3mi)
* fix: update ctest directory for cmake tests to use 'build/debug' ([10cb76c](https://github.com/gha3mi/forunittest/commit/10cb76c3fdda1f9bb7346fb857446392c3ca8976)) by [@gha3mi](https://github.com/gha3mi)
* fix: use fpm.rsp file for CI ([43fe289](https://github.com/gha3mi/forunittest/commit/43fe289bd88aa0bde73203dc0ca135ec45e0058a)) by [@gha3mi](https://github.com/gha3mi)
* fix: update cmake test paths to use 'build/debug' and 'build/release' ([aeeca2c](https://github.com/gha3mi/forunittest/commit/aeeca2c4b8401f93754c44f8aaa364d102b4dcaa)) by [@gha3mi](https://github.com/gha3mi)
* fix: add /cpp flag for ifx on windows ([3293a7e](https://github.com/gha3mi/forunittest/commit/3293a7e713ad9ba6fd4100d518d0372a9057c7e8)) by [@gha3mi](https://github.com/gha3mi)
* fix: remove /cpp flag for ifx on windows ([e912cd7](https://github.com/gha3mi/forunittest/commit/e912cd7ff7dcce54d8eda2d58f7487a16d4a2fe7)) by [@gha3mi](https://github.com/gha3mi)
* fix: disable test builds by default and improve source file globbing ([626b561](https://github.com/gha3mi/forunittest/commit/626b5616014ef595ccb5b1291cfc4469bb9fde4a)) by [@gha3mi](https://github.com/gha3mi)
* fix: avoid real equality comparison (gfortran warning) ([b1fdafd](https://github.com/gha3mi/forunittest/commit/b1fdafdb44098c0fc8288ddc04ab8c2876f41c77)) by [@gha3mi](https://github.com/gha3mi)

### Others

* Remove integer kinds ([6a59886](https://github.com/gha3mi/forunittest/commit/6a5988683d8b7547144f9d7f82f58ec3fcf5402b)) by [@gha3mi](https://github.com/gha3mi)
* Rep. %re & %im with real & aimag for nvfortran bug ([2cb5aee](https://github.com/gha3mi/forunittest/commit/2cb5aee822766ab7e262349c1e3e25f889ebf1f9)) by [@gha3mi](https://github.com/gha3mi)
* Update CI workflows, add CMake support , and update  source files ([d6da7ce](https://github.com/gha3mi/forunittest/commit/d6da7ce0d224ee4fc34dc9a556660943f975be40)) by [@gha3mi](https://github.com/gha3mi)
* (CI-CD): use setup-fortran-conda ([8116334](https://github.com/gha3mi/forunittest/commit/81163346d941ea4db71f7548367f292448fe2f5d)) by [@gha3mi](https://github.com/gha3mi)
* Add STATUS section to README.md ([624d7e3](https://github.com/gha3mi/forunittest/commit/624d7e34277b5484604ccc000a3dd3177c2e39cd)) by [@gha3mi](https://github.com/gha3mi)
* Update FORD documentation output directory configuration ([dd0cd5f](https://github.com/gha3mi/forunittest/commit/dd0cd5f2aa3acad7d5ed7d0b83b52bbcb8177835)) by [@gha3mi](https://github.com/gha3mi)
* Fix header casing for consistency in README.md ([1c5a5ca](https://github.com/gha3mi/forunittest/commit/1c5a5cabd964147c55d8dd08e9de3cbbd29f4782)) by [@gha3mi](https://github.com/gha3mi)
* Update README.md status table [ci skip] ([8136b36](https://github.com/gha3mi/forunittest/commit/8136b36647c22a9d2dba60a3400ba73e5dcab428)) by [@gha3mi](https://github.com/gha3mi)
* chore: clean up documentation setup ([a34558b](https://github.com/gha3mi/forunittest/commit/a34558bd54a4fd70849be3cb8ff139f0ee6d9847)) by [@gha3mi](https://github.com/gha3mi)
* Update README.md status table [ci skip] (#4) ([fde646f](https://github.com/gha3mi/forunittest/commit/fde646f5131743ccd3ad99efa88664aafe6b8606)) by [@gha3mi](https://github.com/gha3mi)


### Contributors
- [@gha3mi](https://github.com/gha3mi)



Full Changelog: [v0.1.0...v0.2.0](https://github.com/gha3mi/forunittest/compare/v0.1.0...v0.2.0)
