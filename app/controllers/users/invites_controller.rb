class Users::InvitesController < ApplicationController

  def show
    if current_client_user
      @promoter_link = "client.com:3000/users/sign_up?promoter=#{current_client_user.email}"
    else
      @promoter_link = "client.com:3000/users/sign_up"
    end
    qrcode = RQRCode::QRCode.new(@promoter_link)

    @svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
  end
end
