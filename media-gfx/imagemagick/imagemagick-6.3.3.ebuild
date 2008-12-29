# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-6.3.3.ebuild,v 1.14 2008/12/29 05:15:22 robbat2 Exp $

inherit eutils multilib perl-app

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV}

DESCRIPTION="A collection of tools and libraries for many image formats"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="mirror://imagemagick/${MY_P}-8.tar.bz2
		 mirror://imagemagick/legacy/${MY_P}-8.tar.bz2"

LICENSE="imagemagick"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="bzip2 doc fpx graphviz gs jbig jpeg jpeg2k lcms mpeg nocxx perl png tiff truetype X wmf xml zlib"

RDEPEND="bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )
	X? (
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
	)
	gs? ( virtual/ghostscript )
	lcms? ( >=media-libs/lcms-1.06 )
	mpeg? ( >=media-video/mpeg2vidcodec-12 )
	png? ( media-libs/libpng )
	tiff? ( >=media-libs/tiff-3.5.5 )
	xml? ( >=dev-libs/libxml2-2.4.10 )
	truetype? ( =media-libs/freetype-2* media-fonts/corefonts )
	wmf? ( >=media-libs/libwmf-0.2.8 )
	jbig? ( media-libs/jbigkit )
	jpeg? ( >=media-libs/jpeg-6b )
	jpeg2k? ( media-libs/jasper )
	perl? ( >=dev-lang/perl-5.8.6-r6 !=dev-lang/perl-5.8.7 )
	!dev-perl/perlmagick
	!sys-apps/compare
	graphviz? ( >=media-gfx/graphviz-2.6 )
	fpx? ( media-libs/libfpx )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/libtool-1.5.2-r6
	X? ( x11-proto/xextproto )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-${PV}-docs.patch

}

src_compile() {
	econf \
		--with-threads \
		--with-modules \
		$(use_with perl) \
		--with-gs-font-dir=/usr/share/fonts/default/ghostscript \
		$(use_with truetype windows-font-dir /usr/share/fonts/corefonts) \
		$(use_with !nocxx magick-plus-plus) \
		$(use_with bzip2 bzlib) \
		$(use_with fpx) \
		$(use_with gs gslib) \
		$(use_with graphviz gvc) \
		$(use_with jbig) \
		$(use_with jpeg jpeg) \
		$(use_with jpeg2k jp2) \
		$(use_with lcms) \
		$(use_with mpeg mpeg2) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with truetype ttf) \
		$(use_with wmf) \
		$(use_with xml) \
		$(use_with zlib) \
		$(use_with X x) \
		|| die "econf failed"
	emake || die "compile problem"

}

src_install() {
	make DESTDIR="${D}" install || die
	dosed "s:-I/usr/include ::" /usr/bin/Magick{,++}-config

	# dont need these files with runtime plugins
	rm -f "${D}"/usr/$(get_libdir)/*/*/*.{la,a}

	! use doc && rm -r "${D}"/usr/share/doc/${PF}/html
	dodoc NEWS ChangeLog AUTHORS README.txt QuickStart.txt Install-unix.txt

	# Fix perllocal.pod file collision
	use perl && fixlocalpod

}
