# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-2.0.17.ebuild,v 1.13 2012/05/13 11:34:57 swift Exp $

EAPI="3"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/gnupg/${P}.tar.bz2"
# SRC_URI="ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="adns bzip2 caps doc ldap nls openct pcsc-lite static selinux smartcard"

COMMON_DEPEND_LIBS="
	>=dev-libs/libassuan-2
	>=dev-libs/libgcrypt-1.4
	>=dev-libs/libgpg-error-1.7
	>=dev-libs/libksba-1.0.7
	>=dev-libs/pth-1.3.7
	>=net-misc/curl-7.10
	sys-libs/zlib
	adns? ( >=net-libs/adns-1.4 )
	bzip2? ( app-arch/bzip2 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )
	openct? ( >=dev-libs/openct-0.5.0 )
	smartcard? ( =virtual/libusb-0* )
	ldap? ( net-nds/openldap )"
COMMON_DEPEND_BINS="|| ( app-crypt/pinentry app-crypt/pinentry-qt )"

# Existence of executables is checked during configuration.
DEPEND="${COMMON_DEPEND_LIBS}
	${COMMON_DEPEND_BINS}
	static? (
		>=dev-libs/libassuan-2[static-libs]
		>=dev-libs/libgcrypt-1.4[static-libs]
		>=dev-libs/libgpg-error-1.7[static-libs]
		>=dev-libs/libksba-1.0.7[static-libs]
	)
	nls? ( sys-devel/gettext )
	doc? ( sys-apps/texinfo )"

RDEPEND="!static? ( ${COMMON_DEPEND_LIBS} )
	${COMMON_DEPEND_BINS}
	virtual/mta
	!app-crypt/gpg-agent
	!<=app-crypt/gnupg-2.0.1
	selinux? ( sec-policy/selinux-gpg )
	nls? ( virtual/libintl )"

pkg_setup() {
	if { use openct || use pcsc-lite; } && ! use smartcard; then
		ewarn "You have openct or pcsc-lite enabled but do not"
		ewarn "have smartcard support enabled. This will not affect"
		ewarn "the building of this package, but it may affect others."
	fi
}

src_configure() {
	local want_scdaemon="0"
	if use openct || use pcsc-lite || use smartcard; then
		want_scdaemon="1"
	fi

	# 'USE=static' support was requested:
	# gnupg1: bug #29299
	# gnupg2: bug #159623
	if use static; then
		append-ldflags -static
		# bug #219423
		if [[ "${want_scdaemon}" -eq 1 ]]; then
			die "Upstream explicitly disallows static builds when combining with smartcard support: http://www.mail-archive.com/gnupg-users@gnupg.org/msg10851.html"
		fi
	fi

	[[ "${want_scdaemon}" -eq 1 ]] && myconf="--enable-scdaemon" || myconf="--disable-scdaemon"

	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-gpg \
		--enable-gpgsm \
		--enable-agent \
		${myconf} \
		$(use_with adns) \
		$(use_enable bzip2) \
		$(use_enable !elibc_SunOS symcryptrun) \
		$(use_enable nls) \
		$(use_enable ldap) \
		$(use_with caps capabilities) \
		CC_FOR_BUILD="$(tc-getBUILD_CC)"
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		cd doc
		emake html || die "emake html failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake DESTDIR="${D}" -f doc/Makefile uninstall-nobase_dist_docDATA || die
	rm -r "${ED}usr/share/gnupg/help"* || die

	dodoc ChangeLog NEWS README THANKS TODO VERSION doc/FAQ doc/DETAILS \
	doc/HACKING doc/TRANSLATE doc/OpenPGP doc/KEYSERVER doc/help* || die "dodoc failed"

	dosym gpg2 /usr/bin/gpg || die
	dosym gpgv2 /usr/bin/gpgv || die
	dosym gpg2keys_hkp /usr/libexec/gpgkeys_hkp || die
	dosym gpg2keys_finger /usr/libexec/gpgkeys_finger || die
	dosym gpg2keys_curl /usr/libexec/gpgkeys_curl || die
	if use ldap; then
		dosym gpg2keys_ldap /usr/libexec/gpgkeys_ldap || die
	fi
	echo ".so man1/gpg2.1" > "${ED}usr/share/man/man1/gpg.1"
	echo ".so man1/gpgv2.1" > "${ED}usr/share/man/man1/gpgv.1"

	dodir /etc/env.d || die
	echo "CONFIG_PROTECT=/usr/share/gnupg/qualified.txt" >>"${ED}etc/env.d/30gnupg"

	if use doc; then
		dohtml doc/gnupg.html/* doc/*.png || die "dohtml failed"
	fi
}

pkg_postinst() {
	elog "If you wish to view images emerge:"
	elog "media-gfx/xloadimage, media-gfx/xli or any other viewer"
	elog "Remember to use photo-viewer option in configuration file to activate"
	elog "the right viewer."

	ewarn "Please remember to restart gpg-agent if a different version"
	ewarn "of the agent is currently used. If you are unsure of the gpg"
	ewarn "agent you are using please run 'killall gpg-agent',"
	ewarn "and to start a fresh daemon just run 'gpg-agent --daemon'."
}
