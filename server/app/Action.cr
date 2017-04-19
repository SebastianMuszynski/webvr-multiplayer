class Action
  def initialize(@type_ : String, @payload : String)
  end

  def self.enemies(enemies : Array(Enemy))
    new("ENEMIES", enemies.to_json)
  end

  JSON.mapping(
    type_: String,
    payload: String
  )
end
