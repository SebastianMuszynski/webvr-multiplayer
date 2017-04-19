class Enemy
  def id
    @id ||= SecureRandom.uuid
  end

  JSON.mapping(
    position: { type: Position, nilable: false }
  )
end
