class LookupByBlockCoactor < ApplicationCoactor
  coact do
    Coactive::Loader.call('app/coactors')
    ApplicationCoactor.descendants.select { |klass| klass.name =~ /^Lookups::/ }.sort_by(&:name)
  end
end
