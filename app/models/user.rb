class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

    ##
  # Confirm that the user is the owner of the chat room.
  # @params [Model]   chatroom
  # @return [Boolean]
  def is_owner?(room)
    if room.user_id == self.id
      true
    else
      false
    end
  end

  ##
  # Confirm that the user is the member of the chat room.
  # @params [Model]   chatroom
  # @return [Boolean]
  def is_member?(room)
    if RoomUser.find_by(room_id: room.id, user_id: self.id)
      true
    else
      false
    end
  end

  ##
  # Confirm that the user can access the chat room.
  # @params [Model]   chatroom
  # @return [Boolean]
  def can_access?(room)
    if self.is_member? (room)
      true
    elsif self.is_owner?(room)
      true
    else
      false
    end
  end
end
