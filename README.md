# [Pour](http://mtwilliams.github.io/pour)

[![Gem Version](https://img.shields.io/gem/v/pour.svg)](https://rubygems.org/gems/pour)
[![Build Status](https://img.shields.io/travis/mtwilliams/pour/master.svg)](https://travis-ci.org/mtwilliams/pour)
[![Code Climate](https://img.shields.io/codeclimate/github/mtwilliams/pour.svg)](https://codeclimate.com/github/mtwilliams/pour)
[![Dependency Status](https://img.shields.io/gemnasium/mtwilliams/pour.svg)](https://gemnasium.com/mtwilliams/pour)

:construction: Allow time to cure!

```Ruby
class Verse
  include Pourable

  property :meaning_of_life, :integer, :default => 42,

  many :inhabitants, Inhabitant, :id => :name,
                                 :merge => false
end

class Inhabitant
  include Pourable

  named

  property :loves_dark_chocolate, :boolean, :default => true
  property :loves_red_wine, :boolean, :default => true
end

universe = Verse.new do |universe|
  universe.inhabitant name: 'Michael Williams' do |mike|
    mike.loves_dark_chocolate = true
    mike.loves_red_wine = true
  end
end
```
