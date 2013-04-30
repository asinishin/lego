class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

class Hash
  # Return a new hash with all keys converted to strings.
  #
  # { :name => 'Rob', :years => '28' }.stringify_keys
  # #=> { "name" => "Rob", "years" => "28" }
  def stringify_keys
    dup.stringify_keys!
  end

  # Destructively convert all keys to strings. Same as
  # +stringify_keys+, but modifies +self+.
  def stringify_keys!
    keys.each do |key|
      self[key.to_s] = delete(key)
    end
    self
  end

  # Return a new hash with all keys converted to symbols, as long as
  # they respond to +to_sym+.
  #
  # { 'name' => 'Rob', 'years' => '28' }.symbolize_keys
  # #=> { :name => "Rob", :years => "28" }
  def symbolize_keys
    dup.symbolize_keys!
  end

  # Destructively convert all keys to symbols, as long as they respond
  # to +to_sym+. Same as +symbolize_keys+, but modifies +self+.
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end

  def decamelize
    self.inject({}){|r, e| r.merge!(e[0].underscore => e[1])}
  end
end
