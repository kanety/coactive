class LookupByBlockCoactor < ApplicationCoactor
  coact do
    Coactive::Autoloader.load('app/coactors')
    ApplicationCoactor.descendants.select { |klass| klass.name =~ /^Lookups::/ }.sort_by(&:name)
  end
end
