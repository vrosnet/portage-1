# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perlbal/Perlbal-1.770.ebuild,v 1.1 2011/01/17 12:43:53 tove Exp $

EAPI=3

MODULE_AUTHOR=DORMANDO
MODULE_VERSION=1.77
inherit perl-module

DESCRIPTION="Reverse-proxy load balancer and webserver"
HOMEPAGE="http://www.danga.com/perlbal/"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl
		>=dev-perl/Danga-Socket-1.57
		dev-perl/Sys-Syscall
		dev-perl/BSD-Resource
		dev-perl/IO-AIO"
DEPEND="${RDEPEND}"
#SRC_TEST="do" # testing not available on Perlbal yet ;-)

PATCHES=( "${FILESDIR}/${PN}-1.58-Use-saner-name-in-process-listing.patch" )

src_install() {
	perl-module_src_install || die "perl-module_src_install failed"
	cd "${S}"
	dodoc doc/*.txt
	docinto hacking
	dodoc doc/hacking/*.txt
	docinto conf
	dodoc conf/*.{dat,conf}
	keepdir /etc/perlbal
	newinitd "${FILESDIR}"/perlbal_init.d_1.58 perlbal
	newconfd "${FILESDIR}"/perlbal_conf.d_1.58 perlbal
}

pkg_postinst() {
	einfo "Please see the example configuration files located"
	einfo "within /usr/share/doc/${PF}/conf/"
}
