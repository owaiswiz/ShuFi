class DevicesController < ApplicationController
  def add
    device = Device.new(name: params[:name], mac: params[:mac])
    if device.save
      render json: { id: device.id}
    else
      head :error
    end
  end

  def allow
    change_device_status(id: params[:id], allowed: true)
  end

  def deny
    change_device_status(id: params[:id], allowed: false)
  end

  def edit
    device = Device.find_by(id: params[:id])
    if device and device.update_attributes(device_params)
      render json: { id: device.id }
    else
      head :error
    end
  end

  def delete 
    device = Device.find_by(id: params[:id])
    if device and device.destroy
      render json: { id: device.id }
    else
      head :error
    end

  end
  def show
    render json: { devices: Device.all }
  end


  private

  def change_device_status(id:, allowed:) 
    device = Device.find_by(id: id)
    if device and device.update_attributes(allowed: allowed)
      render json: { id: device.id }
    else
      head :error
    end
  end

  def device_params
    params.permit(:name, :mac).reject { |_, v| v.blank? }
  end

end
