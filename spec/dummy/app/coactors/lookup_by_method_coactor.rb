class LookupByMethodCoactor < ApplicationCoactor
  coact :lookup_coactors

  private

  def lookup_coactors
    Coactive::Loader.call('app/coactors')
    ApplicationCoactor.descendants.select { |klass| klass.name =~ /^Lookups::/ }.sort_by(&:name)
  end
end
