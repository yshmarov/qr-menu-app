Rails.application.config.session_store :active_record_store,
                                       key: "_api_management_app_session"
# Rails.application.config.session_store :cache_store,
#   expire_after: 90.minutes,
#   key: "_api_management_app_session"

# https://orbit.love/blog/managing-server-side-sessions-in-rails
# https://api.rubyonrails.org/v3.2/classes/ActiveRecord/SessionStore.html
# https://www.rubydoc.info/gems/activerecord-session_store/1.0.0

# ALL ORDERS
#= My order/Basket @current_order.order_items.count
#= request.session.id
#= ActiveRecord::SessionStore::Session.first.attributes
