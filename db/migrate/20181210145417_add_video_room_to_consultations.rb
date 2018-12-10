class AddVideoRoomToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :video_room, :string
  end
end
