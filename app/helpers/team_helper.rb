module TeamHelper
  def default_img(image)
    image.presence || 'default.jpg'
  end
  # そのチームのオーナーであるならtrueを返す
  def owner?
    current_user.id == @team.owner_id
  end
  # チームから削除するメンバーが自分自身であるならtrueを返す
  def yourself?(assign)
    @assign = assign
    current_user.id == @assign.user_id
  end
end
