# Static-rb

[![Build Status](https://github.com/jveillet/static-rb/workflows/CI/badge.svg)](https://github.com/jveillet/static-rb/actions)

A very stripped-down HTTP server built with Ruby and Rack, to serve static assets.

## Prerequisite

* Ruby 2.6
* Docker (optional)
* Compose (optional)

## Installation

```bash
bundle install
```

_OR_ with Docker

```bash
docker-compose build
```

## Usage

```bash
bundle exec rackup
```

_OR_ with Docker

```bash
docker-compose up
```

The website is available at [http://localhost:3000](http://localhost:3000)
