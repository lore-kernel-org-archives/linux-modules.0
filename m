Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>, Bertrand Jacquin <beber@meleeweb.net>, Marco d'Itri <md@linux.it>, linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace support may easily be missing.
In-Reply-To: <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de> <87r3pwgd0b.fsf@rustcorp.com.au> <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
Date: Thu, 04 Jun 2015 11:00:41 +0930
Message-ID: <87h9qouuny.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> On Mon, Jun 1, 2015 at 3:26 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Andreas Mohr <andi@lisas.de> writes:
>>> Hi,
>>>
>>> I just had a not so nice experience
>>> when finally upgrading to a new 4.1-rc5
>>> with CONFIG_MODULE_COMPRESS newly enabled -
>>> userspace binary parts (kmod 18 or 20 in my case)
>>> did not have compression enabled
>>> (at least on Debian 8pre, vs. encountering it enabled on FC21)
>>> since it does not seem to be
>>> the default build configuration of kmod (yet?).
>>
>> Sure.  Let's get the maintainers to insert the actual version required
>> in the help text though.
>
> kmod supports gz since the first version and xz since version 3.  So both
> of them can be safely fall into "it's supported since the beginning of
> kmod IMO".

Thanks, that's what I needed.

But disappointing that Debian doesn't configure with it, and there's no
easy way to check it.  Looks like Ubuntu vivid is the same.

Might be time to change the default in kmod?

Anyway, here's my patch, comments welcome.

Subject: modules: clarify CONFIG_MODULE_COMPRESS help, suggest 'N'.

Andreas turned this option on, only to find out Debian (and Ubuntu!)
don't enable support in their kmod builds.

Shorten the text, and suggest N at the bottom (at least for now).

Reported-by: Andreas Mohr <andim2@users.sf.net>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/init/Kconfig b/init/Kconfig
index 968a001790af..5422c44be5f0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1948,26 +1948,22 @@ config MODULE_COMPRESS
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
+	  module-init-tools supports gzip, and kmod can be configured to handle
+	  gzip and xz (but doesn't by default, at least as of version 18!).
 
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
