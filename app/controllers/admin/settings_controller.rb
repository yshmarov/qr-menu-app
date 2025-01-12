module Admin
  class SettingsController < SecuredController
    include ActiveModel::Model

    def create
      @errors = ActiveModel::Errors.new(self)

      setting_params.keys.each do |key|
        next if setting_params[key].nil?

        setting = Setting.new(var: key)
        setting.value = setting_params[key].strip
        @errors.merge!(setting.errors) unless setting.valid?
      end

      if @errors.any?
        render :show, status: :unprocessable_entity
        return
      end

      setting_params.keys.each do |key|
        Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
      end

      redirect_to admin_settings_path, notice: "Settings updated successfully"
    end

    private

    def setting_params
      allowed_fields = Setting.defined_fields.map { |f| f[:key] }
      params.require(:setting).permit(*allowed_fields)
    end
  end
end
