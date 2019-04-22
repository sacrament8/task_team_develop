class AssignsController < ApplicationController
  before_action :authenticate_user!
  before_action :remove_restrictions, only: [:destroy]

  def create
    team = Team.friendly.find(params[:team_id])
    user = email_reliable?(assign_params) ? User.find_or_create_by_email(assign_params) : nil
    if user
      team.invite_member(user)
      redirect_to team_url(team), notice: 'アサインしました！'
    else
      redirect_to team_url(team), notice: 'アサインに失敗しました！'
    end
  end
  # チームからメンバーを削除するアクション
  def destroy
    assign = Assign.find(params[:id])
    destroy_message = assign_destroy(assign, assign.user)

    redirect_to team_url(params[:team_id]), notice: destroy_message
  end

  private

  def assign_params
    params[:email]
  end

  def assign_destroy(assign, assigned_user)
    if assigned_user == assign.team.owner
      'リーダーは削除できません。'
    elsif Assign.where(user_id: assigned_user.id).count == 1
      'このユーザーはこのチームにしか所属していないため、削除できません。'
    elsif assign.destroy
      set_next_team(assign, assigned_user)
      'メンバーを削除しました。'
    else
      'なんらかの原因で、削除できませんでした。'
    end    
  end  
  
  def email_reliable?(address)
    address.match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end
  
  def set_next_team(assign, assigned_user)
    another_team = Assign.find_by(user_id: assigned_user.id).team
    change_keep_team(assigned_user, another_team) if assigned_user.keep_team_id == assign.team_id
  end

  # 現在閲覧ページのteamレコードを取得
  def get_current_team
    @team = Team.find_by(name: params[:team_id])
  end
  # そのチームのオーナーであるならtrueを返す
  def owner?
    get_current_team
    current_user.id == @team.owner_id
  end
  # チームから削除するメンバーが自分自身であるならtrueを返す
  def yourself?
    @assign = Assign.find(params[:id])
    current_user.id == @assign.user_id
  end

  def remove_restrictions
    unless owner? || yourself?
      redirect_to team_url(params[:team_id]), notice: "メンバー削除は自身かオーナーのみ実行可能です"
    end
  end
end
