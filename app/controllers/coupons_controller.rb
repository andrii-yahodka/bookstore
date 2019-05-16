class CouponsController < ApplicationController
  before_action :apply_coupon

  def update; end

  private

  def apply_coupon
    if Coupons::ManageCouponService.new(current_order, coupon_params).apply
      flash[:success] = t('message.success.coupon.use')
    else
      flash[:danger] = t('message.error.coupon.used')
    end

    redirect_to @page_presenter.previous_url
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end
