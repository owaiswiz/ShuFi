class DevicesController < ApplicationController
  def add
    device = Device.new(name: params[:name], mac: params[:mac])
    if device.save
      status = 'Device added successfully'
    else
      status = 'Error occurred while adding device'
    end
    render json: { status: status, id: device.id}
  end

  def allow
  end

  def deny
  end

  def edit
  end
end
