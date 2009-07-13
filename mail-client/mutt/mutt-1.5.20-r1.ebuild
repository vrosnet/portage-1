# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt/mutt-1.5.20-r1.ebuild,v 1.1 2009/07/02 08:44:33 grobian Exp $

inherit eutils flag-o-matic autotools

PATCHSET_REV="-r2"

# note: latest sidebar patches can be found here:
# http://www.lunar-linux.org/index.php?option=com_content&task=view&id=44
SIDEBAR_PATCH_N="patch-1.5.20.sidebar.20090619.txt"

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/${P}.tar.gz
	!vanilla? (
		!sidebar? (
			mirror://gentoo/${P}-gentoo-patches${PATCHSET_REV}.tar.bz2
			http://dev.gentoo.org/~grobian/distfiles/${P}-gentoo-patches${PATCHSET_REV}.tar.bz2
		)
	)
	sidebar? (
		http://www.lunar-linux.org/~tchan/mutt/${SIDEBAR_PATCH_N}
	)"
IUSE="berkdb crypt debug gdbm gnutls gpgme idn imap mbox nls nntp pop qdbm sasl
sidebar smime smtp ssl vanilla"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
RDEPEND=">=sys-libs/ncurses-5.2
	qdbm?    ( dev-db/qdbm )
	!qdbm?   (
		gdbm?  ( sys-libs/gdbm )
		!gdbm? ( berkdb? ( >=sys-libs/db-4 ) )
	)
	imap?    (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	pop?     (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	smtp?     (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	idn?     ( net-dns/libidn )
	gpgme?   ( >=app-crypt/gpgme-0.9.0 )
	smime?   ( >=dev-libs/openssl-0.9.6 )
	app-misc/mime-types"
DEPEND="${RDEPEND}
	net-mail/mailbase
	!vanilla? (
		dev-libs/libxml2
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
		|| ( www-client/lynx www-client/w3m www-client/elinks )
	)"

PATCHDIR="${WORKDIR}"/${P}-gentoo-patches${PATCHSET_REV}

src_unpack() {
	unpack ${A//${SIDEBAR_PATCH_N}}
	cd "${S}"

	# this patch is non-generic and only works because we use a sysconfdir
	# different from the one used by the mailbase ebuild
	use prefix && epatch "${FILESDIR}"/mutt-1.5.13-prefix-mailcap.patch

	epatch "${FILESDIR}"/mutt-1.5.18-bdb-prefix.patch # fix bdb detection
	epatch "${FILESDIR}"/mutt-1.5.18-interix.patch
	epatch "${FILESDIR}"/mutt-1.5.18-solaris-ncurses-chars.patch
	# post-release hot-fixes
	epatch "${FILESDIR}"/mutt-1.5.20-imap-port-invalid-d6f88fbf8387.patch
	epatch "${FILESDIR}"/mutt-1.5.20-header-weeding-f40de578e8ed.patch
	epatch "${FILESDIR}"/mutt-1.5.20-display-unsigned-pgp-7f37d0a57d83.patch
	epatch "${FILESDIR}"/mutt-1.5.20-unmailbox-segfault-25e46aad362b.patch
	epatch "${FILESDIR}"/mutt-1.5.20-mbox-new-mail-bd59be56c6b0.patch
	epatch "${FILESDIR}"/mutt-1.5.20-mbox-unchanged-new-mail-9ae13dedb5ed.patch
	epatch "${FILESDIR}"/mutt-1.5.20-imap-start-fatal-fe30f394cbe6.patch
	epatch "${FILESDIR}"/mutt-1.5.20-tab-subject-questionmark-298194c414f0.patch
	epatch "${FILESDIR}"/mutt-1.5.20-smtp-batch-mode-0a3de4d9a009-f6c6066a5925.patch

	if use !vanilla && use !sidebar ; then
		use nntp || rm "${PATCHDIR}"/06-nntp.patch
		for p in "${PATCHDIR}"/*.patch ; do
			epatch "${p}"
		done
	fi

	if use sidebar ; then
		use vanilla || \
			ewarn "The sidebar patch is only applied to a vanilla mutt tree."
		epatch "${DISTDIR}"/${SIDEBAR_PATCH_N}
	fi

	AT_M4DIR="m4" eautoreconf

	# this should be done only when we're not root
	if [[ ${UID} != 0 ]] ; then
		sed -i \
			-e 's/@DOTLOCK_GROUP@/'"`id -gn`"'/g' \
			Makefile.in \
			|| die "sed failed"
	fi
}

src_compile() {
	declare myconf="
		$(use_enable nls) \
		$(use_enable gpgme) \
		$(use_enable imap) \
		$(use_enable pop) \
		$(use_enable smtp) \
		$(use_enable crypt pgp) \
		$(use_enable smime) \
		$(use_enable debug) \
		$(use_with idn) \
		--with-curses \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PN}-${PVR} \
		--with-regex \
		--enable-nfs-fix --enable-external-dotlock \
		$(use_with !nntp mixmaster) \
		--with-exec-shell=${EPREFIX}/bin/sh"

	case $CHOST in
		*-darwin7)
			# locales are broken on Panther
			myconf="${myconf} --enable-locales-fix --without-wc-funcs"
			myconf="${myconf} --disable-fcntl --enable-flock"
		;;
		*-solaris*)
			# Solaris has no flock in the standard headers
			myconf="${myconf} --enable-fcntl --disable-flock"
		;;
		*)
			myconf="${myconf} --disable-fcntl --enable-flock"
		;;
	esac

	# See Bug #22787
	unset WANT_AUTOCONF_2_5 WANT_AUTOCONF

	# mutt prioritizes gdbm over bdb, so we will too.
	# hcache feature requires at least one database is in USE.
	if use qdbm; then
		myconf="${myconf} --enable-hcache \
		--with-qdbm --without-gdbm --without-bdb"
	elif use gdbm ; then
		myconf="${myconf} --enable-hcache \
			--without-qdbm --with-gdbm --without-bdb"
	elif use berkdb; then
		myconf="${myconf} --enable-hcache \
			--without-gdbm --without-qdbm --with-bdb"
	else
		myconf="${myconf} --disable-hcache \
			--without-qdbm --without-gdbm --without-bdb"
	fi

	# there's no need for gnutls, ssl or sasl without socket support
	if use pop || use imap || use smtp ; then
		if use gnutls; then
			myconf="${myconf} --with-gnutls"
		elif use ssl; then
			myconf="${myconf} --with-ssl"
		fi
		# not sure if this should be mutually exclusive with the other two
		myconf="${myconf} $(use_with sasl)"
	else
		myconf="${myconf} --without-gnutls --without-ssl --without-sasl"
	fi

	if use mbox; then
		myconf="${myconf} --with-mailpath=${EPREFIX}/var/spool/mail"
	else
		myconf="${myconf} --with-homespool=Maildir"
	fi

	if use !vanilla && use !sidebar ; then
		# rr.compressed patch
		myconf="${myconf} --enable-compressed"

		# nntp patch applied conditionally, so avoid QA warning when doing
		# --disable-nntp while patch not being applied, bug #262069
		use nntp && myconf="${myconf} --enable-nntp"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	local ED=${ED-${D}}
	make DESTDIR="${D}" install || die "install failed"
	find "${ED}"/usr/share/doc -type f | grep -v "html\|manual" | xargs gzip
	if use mbox; then
		insinto /etc/mutt
		newins "${FILESDIR}"/Muttrc.mbox Muttrc
	else
		insinto /etc/mutt
		doins "${FILESDIR}"/Muttrc
	fi

	# A newer file is provided by app-misc/mime-types. So we link it.
	rm "${ED}"/etc/${PN}/mime.types
	dosym /etc/mime.types /etc/${PN}/mime.types

	# charset.alias is installed by libiconv
	rm -f "${ED}"/usr/lib/charset.alias
	rm -f "${ED}"/usr/share/locale/locale.alias

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_postinst() {
	echo
	elog "If you are new to mutt you may want to take a look at"
	elog "the Gentoo QuickStart Guide to Mutt E-Mail:"
	elog "   http://www.gentoo.org/doc/en/guide-to-mutt.xml"
	echo
}