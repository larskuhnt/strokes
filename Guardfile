guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/strokes/(.+)\.rb})     { |m| "spec/lib/strokes/#{m[1]}_spec.rb" }
  watch('lib/strokes.rb') { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
end
