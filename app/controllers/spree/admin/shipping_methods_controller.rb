module Spree
  module Admin
    class ShippingMethodsController < ResourceController
      before_filter :load_data, :except => [:index]
      before_filter :set_shipping_category, :only => [:create, :update]

      def destroy
        @object.touch :deleted_at

        flash[:success] = flash_message_for(@object, :successfully_removed)

        respond_with(@object) do |format|
          format.html { redirect_to collection_url }
          format.js  { render_js_for_destroy }
        end
      end

      private

      def set_shipping_category
        return true if params[:shipping_method][:shipping_category_id] == ""
        @shipping_method.shipping_category = Spree::ShippingCategory.find(params[:shipping_method][:shipping_category_id])
        @shipping_method.save
        params[:shipping_method].delete(:shipping_category_id)
      end

      def location_after_save
        edit_admin_shipping_method_path(@shipping_method)
      end

      def load_data
        @available_zones = Zone.order(:name)
        @calculators = ShippingMethod.calculators.sort_by(&:name)
      end
    end
  end
end
