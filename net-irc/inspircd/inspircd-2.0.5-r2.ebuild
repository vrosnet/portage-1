# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-2.0.5-r2.ebuild,v 1.3 2012/05/21 09:39:41 phajdan.jr Exp $

EAPI=4

inherit eutils flag-o-matic multilib

DESCRIPTION="Inspire IRCd - The Stable, High-Performance Modular IRCd"
HOMEPAGE="http://www.inspircd.org/"
SRC_URI="http://github.com/inspircd/inspircd/downloads/InspIRCd-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnutls ipv6 ldap mysql postgres sqlite ssl"

RDEPEND="
	dev-lang/perl
	ssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls dev-libs/libgcrypt )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	sqlite? ( >=dev-db/sqlite-3.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_prepare() {
	# Patch the inspircd launcher with the inspircd user
	sed -i -e "s/@UID@/${PN}/" "${S}/make/template/${PN}" || die

	epatch "${FILESDIR}/${PF}-fix-paths-build.patch"
}

src_configure() {
	local extras=""
	local dipv6="--disable-ipv6"

	use ssl && extras="${extras}m_ssl_openssl.cpp,"
	use gnutls && extras="${extras}m_ssl_gnutls.cpp,"
	use ldap && extras="${extras}m_ldapauth.cpp,"
	use mysql && extras="${extras}m_mysql.cpp,"
	use postgres && extras="${extras}m_pgsql.cpp,"
	use sqlite && extras="${extras}m_sqlite3.cpp,"

	use ipv6 && dipv6=""

	# allow inspircd to be built by root
	touch .force-root-ok || die

	if [ -n "${extras}" ]; then
		./configure --disable-interactive \
			--enable-extras=${extras} || die
	fi

	./configure \
		--disable-interactive \
		--uid=${INSPIRCDUSER} \
		$(use_enable ssl openssl) \
		$(use_enable gnutls) \
		--prefix="/usr/$(get_libdir)/${PN}" \
		--config-dir="/etc/${PN}" \
		--binary-dir="/usr/bin" \
		--module-dir="/usr/$(get_libdir)/${PN}/modules" \
		${dipv6} || die
}

src_compile() {
	append-cxxflags -Iinclude -fPIC
	emake LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake INSTUID=${PN} \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/$(get_libdir)/${PN}/inspircd.launcher" \
		MODPATH="${D}/usr/$(get_libdir)/${PN}/modules/" \
		CONPATH="${D}/etc/${PN}" install

	insinto /etc/"${PN}"/modules
	doins docs/modules/*

	insinto /etc/"${PN}"/aliases
	doins docs/aliases/*

	insinto /usr/include/"${PN}"/
	doins include/*

	diropts -o"${PN}" -g"${PN}"
	dodir /var/run/"${PN}" /var/lib/"${PN}"/data

	newinitd "${FILESDIR}/${PN}-2.0.5-r1-init" "${PN}"
	keepdir /var/log/"${PN}"/
}

pkg_postinst() {
	elog "Before starting ${PN} the first time you should create"
	elog "the /etc/${PN}/${PN}.conf file."
	elog "You can find example configuration files under /etc/${PN}"
	elog "Read the ${PN}.conf.example file carefully before starting "
	elog "the service."
	elog
}
