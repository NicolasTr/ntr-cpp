Description
===========

<a href="https://github.com/NicolasTr/ntr-cpp/releases">Download the current version</a>

This repository contains the necessary code to compile different C++ libraries for Android and iOS.

At the moment, the libraries are compiled in debug mode.

If you have any question, please feel free to contact me.

Status
======

| Build system| Status                                                                                                                                       | Android | iOS |
|:-----------:|:--------------------------------------------------------------------------------------------------------------------------------------------:|:-------:|:---:|
| Travis      | [![Build Status](https://travis-ci.org/NicolasTr/ntr-cpp.svg?branch=master)](https://travis-ci.org/NicolasTr/ntr-cpp)                        |   yes   |     |
| CircleCI    | [![Circle CI](https://circleci.com/gh/NicolasTr/ntr-cpp/tree/master.png?style=badge)](https://circleci.com/gh/NicolasTr/ntr-cpp/tree/master) |   yes   |     |
| Manual      |                                                                                                                                              |         | yes |


Libraries
=========

| Name                                              | Version        | Licence                                                                                     | Why I use it                  |
|:-------------------------------------------------:|:--------------:|:-------------------------------------------------------------------------------------------:|:----------------------------- |
| [boost](http://www.boost.org/)                    | 1.55.0         | [Boost Software Licence](Boost_Software_License)                                            | Smart pointers                |
| [thrift](https://thrift.apache.org/)              | 0.9.1          | [Apache License 2.0](http://thrift.apache.org/docs/)                                        | Remote procedure calls        |
| [botan](http://botan.randombit.net/)              | 1.10.6         | [BSD-2](http://botan.randombit.net/license.html)                                            | Cryptography                  |
| [sqlite](http://www.sqlite.org/)                  | 3.7.12.1       | [Public Domain](http://www.sqlite.org/copyright.html)                                       | Embedded relational database  |
| [odb](http://www.codesynthesis.com/products/odb/) | 2.3.0          | [GNU GPL v2.0 + Commercial + Free](http://www.codesynthesis.com/products/odb/license.xhtml) | Object-relational mapping     |
