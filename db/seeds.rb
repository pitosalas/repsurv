['root', 'coord', 'user'].each do |role|
  Role.find_or_create_by_name role
end
