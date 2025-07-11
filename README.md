[![GitHub](https://img.shields.io/badge/GitHub-ForUnitTest-blue.svg?style=social&logo=github)](https://github.com/gha3mi/forunittest)
[![Version](https://img.shields.io/github/release/gha3mi/forunittest.svg)](https://github.com/gha3mi/forunittest/releases/latest)
[![Documentation](https://img.shields.io/badge/ford-Documentation%20-blueviolet.svg)](https://gha3mi.github.io/forunittest/)
[![License](https://img.shields.io/github/license/gha3mi/forunittest?color=green)](https://github.com/gha3mi/forunittest/blob/main/LICENSE)
[![Build](https://github.com/gha3mi/forunittest/actions/workflows/CI_test.yml/badge.svg)](https://github.com/gha3mi/forunittest/actions/workflows/CI_test.yml)

<!-- <img alt="ForUnitTest" src="https://github.com/gha3mi/forunittest/raw/main/media/logo.png" width="750"> -->

**ForUnitTest**: A Fortran library for unit testing.

## Usage

```fortran
use forunittest

type(unit_test) :: ut

call ut%check(res, expected, tol, msg)
```

See `example/demo.f90` for a complete example.

## fpm dependency

To use `ForUnitTest` as a dependency in your fpm project, include the following line in your `fpm.toml` file:

```toml
[dependencies]
forunittest = {git="https://github.com/gha3mi/forunittest.git"}
```

## How to Run the Demo

**Clone the repository:**

Clone the `ForUnitTest` repository from GitHub using:

```shell
git clone https://github.com/gha3mi/forunittest.git
cd forunittest
```

**Run the demo:**

```shell
fpm run --example demo
```

## Status

<!-- STATUS:setup-fortran-conda:START -->
| Compiler   | macos | ubuntu | windows |
|------------|----------------------|----------------------|----------------------|
| `flang-new` | - | fpm ✅ | fpm ❌ |
| `gfortran` | fpm ✅ | fpm ✅ | fpm ✅ |
| `ifx` | - | fpm ✅ | fpm ❌ |
| `lfortran` | fpm ❌ | fpm ❌ | fpm ❌ |
| `nvfortran` | - | fpm ✅ | - |
<!-- STATUS:setup-fortran-conda:END -->

## API documentation

The most up-to-date API documentation for the main branch is available
[here](https://gha3mi.github.io/forunittest/).
To generate the API documentation for `ForUnitTest` using
[ford](https://github.com/Fortran-FOSS-Programmers/ford) run the following
command:

```shell
ford ford.yml
```

## Contributing

Contributions to `ForUnitTest` are welcome!
If you find any issues or would like to suggest improvements, please open an issue.
