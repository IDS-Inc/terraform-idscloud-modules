resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = "${var.vpc_id}"
  vpn_gateway_id = "${var.vgw_id}"
}

# Tricky way to nest loop through route_tables and vpn_routes
resource "aws_route" "igw_ipv4" {
  count = "${length(var.route_tables) * length(var.vpn_routes)}"

  route_table_id         = "${var.route_tables[count.index / length(var.vpn_routes)]}"
  destination_cidr_block = "${var.vpn_routes[count.index % length(var.vpn_routes)]}"

  gateway_id = "${var.vgw_id}"
}
