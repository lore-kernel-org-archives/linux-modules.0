Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>, linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace support may easily be missing.
In-Reply-To: <CAKi4VA+4mFsg7VCqr+3wd4dCqUtCW02YP7KYmVYF0prH5bet0g@mail.gmail.com>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de> <87r3pwgd0b.fsf@rustcorp.com.au> <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com> <87h9qouuny.fsf@rustcorp.com.au> <CAKi4VA+4mFsg7VCqr+3wd4dCqUtCW02YP7KYmVYF0prH5bet0g@mail.gmail.com>
Date: Fri, 05 Jun 2015 05:52:24 +0930
Message-ID: <87zj4fte9r.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>> +         gzip and xz (but doesn't by default, at least as of version 18!).
>
> This is pretty much misleading. There's no such a default option. It's
> like saying kernel doesn't support feature X, Y or Z by default
> because make defconfig doesn't turn them on.

Nobody except Linus expects a defconfig to boot.

I expect ./configure to give me a working tool; these *are* defaults,
and setting them *is* your responsibility as author.  When it became an
in-kernel option rather than some weird distro thing, the old default
was wrong.

... Though I hadn't realized that Marco had deliberately decided to
leave support off.  Surprising, since liblzma and libz seem required on
Debian anyway.

So I'm sorry Andreas: if your maintainer doesn't care about your case,
there's not much I can do :(

Subject: modules: clarify CONFIG_MODULE_COMPRESS help, suggest 'N'.

Andreas turned this option on, only to find out Debian (and Ubuntu!)
don't enable support in their kmod builds.

Shorten the text, and suggest N at the bottom (at least for now).

Reported-by: Andreas Mohr <andim2@users.sf.net>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/init/Kconfig b/init/Kconfig
index 968a001790af..bcb7e1e13f7d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1948,26 +1948,21 @@ config MODULE_COMPRESS
 	bool "Compress modules on installation"
 	depends on MODULES
 	help
-	  This option compresses the kernel modules when 'make
-	  modules_install' is run.
 
-	  The modules will be compressed either using gzip or xz depend on the
-	  choice made in "Compression algorithm".
+	  Compresses kernel modules when 'make modules_install' is run; gzip or
+	  xz depending on "Compression algorithm" below.
 
-	  module-init-tools has support for gzip format while kmod handle gzip
-	  and xz compressed modules.
+	  module-init-tools MAY support gzip, and kmod MAY support gzip and xz.
 
-	  When a kernel module is installed from outside of the main kernel
-	  source and uses the Kbuild system for installing modules then that
-	  kernel module will also be compressed when it is installed.
+	  Out-of-tree kernel modules installed using Kbuild will also be
+	  compressed upon installation.
 
-	  This option provides little benefit when the modules are to be used inside
-	  an initrd or initramfs, it generally is more efficient to compress the whole
-	  initrd or initramfs instead.
+	  Note: for modules inside an initrd or initramfs, it's more efficient
+	  to compress the whole initrd or initramfs instead.
 
-	  This is fully compatible with signed modules while the signed module is
-	  compressed. module-init-tools or kmod handles decompression and provide to
-	  other layer the uncompressed but signed payload.
+	  Note: This is fully compatible with signed modules.
+
+	  If in doubt, say N.
 
 choice
 	prompt "Compression algorithm"
