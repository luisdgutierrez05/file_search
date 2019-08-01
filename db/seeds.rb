# Create File samples
puts 'Creating FileResource samples:'

puts 'File 1 with tags: [Tag1, Tag2, Tag3, Tag5]'
FileResource.create(name: 'File 1', tags: %w[Tag1 Tag2 Tag3 Tag5])

puts 'File 2 with tags: [Tag2]'
FileResource.create(name: 'File 2', tags: %w[Tag2])

puts 'File 3 with tags: [Tag2, Tag3, Tag5]'
FileResource.create(name: 'File 3', tags: %w[Tag2 Tag3 Tag5])

puts 'File 4 with tags: [Tag2, Tag3, Tag4, Tag5]'
FileResource.create(name: 'File 4', tags: %w[Tag2 Tag3 Tag4 Tag5])

puts 'File 5 with tags: [Tag3, Tag4]'
FileResource.create(name: 'File 5', tags: %w[Tag3 Tag4])
