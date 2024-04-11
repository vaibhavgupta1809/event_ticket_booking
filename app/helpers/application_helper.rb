module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when "success" then "alert-success"
    when "error" then "alert-danger"
    when "alert" then "alert-warning"
    when "notice" then "alert-info"
    else flash_type.to_s
    end
  end
end
